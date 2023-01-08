import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/Info.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends GetxController {
  bool isSignup = false;
  String? errorMessage = '';

  changeErrorMessage(String s) {
    errorMessage = s;
    update();
  }

  changeisSignup(bool s) {
    isSignup = s;
    update();
  }

  changeistoken(String s) {
    _token = s;
    update();
  }
  changeisuserId(String s) {
    _userId = s;
    update();
  }

  changeExpiryDate(DateTime s) {
    _expiryDate = s;
    update();
  }

  ///
   String? _token;

  late DateTime _expiryDate = DateTime.now().add(Duration(seconds: 2500));
  String _userId = '';
   Timer _authTime =Timer(
     const Duration(seconds: 0),
         () {
       // Navigate to your favorite place
     },

   );

  String? email;

  void setemail(String _email) {
    email = _email;
    update();
  }

  bool get isAuth {
   // print('inside auth ${token?.length}');
   // print('inside auth ${token != null}');
    return token != null;
   // return token!.isEmpty ?  false:true ;
  }

  String? get token {

    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> signin(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    await _authenticate(email, password, 'signUp');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
     if (!prefs.containsKey('userData')) {
      return false;
    }
    getUserInfo();
     if (_expiryDate.isBefore(DateTime.now())) return false;
    // update();
    _autoLogout();
    return true;
  }


  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    changeErrorMessage('');
print('inside auth func');
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAPb2LfILtCTM_kopIGMbmoJ6nYsBARRUg';
    //signUp
    //signInWithPassword
    try {
      Uri uri = Uri.parse(url);
    print(uri);
      final res = await http.post(uri,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureTolken': true
          }));
      print(res);
      print('responsedata00000000000000000');
      final responsedata = json.decode(res.body);

      if (responsedata['error'] != null) {
        changeErrorMessage(responsedata['error']['message'].toString());
        // errorMessage = (responsedata['error']['message']).obs;

        print(responsedata['error']['message']);
      }

      print('responsedata[email]');
      print(responsedata['email']);
        setemail(responsedata['email']);
      changeistoken(responsedata['idToken'].toString());
      changeisuserId(responsedata['localId'].toString());
        changeExpiryDate(DateTime.now().add(Duration(seconds: 3600))); //int.parse(responsedata['expiresIn']))));

   print(_userId);
        saveUserInfo(_token!,_userId,_expiryDate.toString());


      _autoLogout();

      update();




    } catch (e) {
      // throw e;

    }
  }


  Future<Info> getUserInfo() async {
    print(' getUserInfo() ');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = {};
    final String? userStr = prefs.getString('userData');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    final Info info = Info.fromJson(userMap);

changeistoken(info.token.toString());
    changeisuserId(info.userId.toString());
    changeExpiryDate(DateTime.parse(info.expiryDate));
   // print(info);
    return info;
  }

  Future<void> saveUserInfo(String token,String userId,String expiryDate ) async {
    final Info info = Info.fromJson({

        'token':token,
        'userId': userId,
        'expiryDate': expiryDate
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('userData', jsonEncode(info));
    print('the save shared=$result');
  }

  Future<void> logout() async {
 _token=null;
  //  changeistoken();
    changeisuserId('');
    print('token=$_token');
    changeExpiryDate(DateTime.now().add(Duration(seconds: -2000),),);
  //  _expiryDate = DateTime.now().add(Duration(seconds: -2000));

    //if (_authTime != null) {
      _authTime.cancel();
      _authTime = Timer(
        const Duration(seconds: 0),
            () {
          // Navigate to your favorite place
        },

      );
    //}
//dddddddd   fdcccc vcvfvfv
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    update();
  }
///ssssss   ggggg  nhhghghgh
  void _autoLogout() {
    if (_authTime != null) {
      _authTime.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTime = Timer(Duration(seconds: timeToExpiry), logout);
    update();
  }

}
