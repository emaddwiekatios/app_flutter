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

  ///
  late String _token;

  late DateTime _expiryDate = DateTime.now();
  String _userId = '';
  late Timer _authTime;

  String? email;

  void setemail(String _email) {
    email = _email;
    update();
  }

  bool get isAuth {
    return token != null;
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
    if (!prefs.containsKey('userData')) return false;
    prefs.getString('userData');
    final Map<String, Object> extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedData['expiryDate'].toString());
    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedData['token'].toString();
    _userId = extractedData['userId'].toString();
    _expiryDate = expiryDate;
    // update();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = '';
    _userId = '';
    _expiryDate = '' as DateTime;
    if (_authTime != null) {
      _authTime.cancel();
      _authTime = '' as Timer;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    //update();
  }

  void _autoLogout() {
    if (_authTime != null) {
      _authTime.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTime = Timer(Duration(seconds: timeToExpiry), logout);
    //update();
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    print(email);
    print(urlSegment);
    changeErrorMessage('');
    print('responsedata0000');
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAPb2LfILtCTM_kopIGMbmoJ6nYsBARRUg';
    //signUp
    //signInWithPassword
    try {
      print('try');
      Uri uri = Uri.parse(url);
      print(uri);
      final res = await http.post(uri,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureTolken': true
          }));
      print(res);
      print('end try');
      final responsedata = json.decode(res.body);
      print(json.decode(res.body));
      if (responsedata['error'] != null) {
        changeErrorMessage(responsedata['error']['message'].toString());
        // errorMessage = (responsedata['error']['message']).obs;

        print(responsedata['error']['message']);
      }
      if (responsedata['idToken'].toString() != null) {
        setemail(responsedata['email']);
        print('responsedata[email]');
        print(responsedata['email']);

        _token = responsedata['idToken'].toString();
        _userId = responsedata['localId'].toString();
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(responsedata['expiresIn'])));
        _autoLogout();
        update();
        final prefs = await SharedPreferences.getInstance();
        String userData = json.encode(
            {'token': _token, 'userId': _userId, 'expiryDate': _expiryDate});
        prefs.setString('userData', userData);
      }
    } catch (e) {
      // throw e;

    }
  }
}
