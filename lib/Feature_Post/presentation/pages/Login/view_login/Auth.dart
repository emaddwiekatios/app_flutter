import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends GetxController {
  bool isSignup = false;
  String errorMessage = '';

  ///
  late String _token;
  late DateTime _expiryDate;
  String _userId = '';
  late Timer _authTime;

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

  String get userId {
    return _userId;
  }

  Future<void> signin(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<bool> tryAutoLogin(String email, String password) async {
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
    update();
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
    update();
  }

  void _autoLogout() {
    if (_authTime != null) {
      _authTime.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTime = Timer(Duration(seconds: timeToExpiry), logout);
    update();
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    // setState(() {
    //   errorMessage = '';
    // });

    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAPb2LfILtCTM_kopIGMbmoJ6nYsBARRUg';
    //signUp
    //signInWithPassword
    try {
      Uri uri = Uri.parse(url);
      final res = await http.post(uri,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureTolken': true
          }));
      final responsedata = json.decode(res.body);
      if (responsedata['error'] != null) {
        // setState(() {
        //   errorMessage = responsedata['error']['message'];
        // });

        print(responsedata['error']['message']);
      }

      _token = responsedata['idToken'];
      _userId = responsedata['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responsedata['expiresIn'])));
      _autoLogout();
      update();
      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode(
          {'token': _token, 'userId': _userId, 'expiryDate': _expiryDate});
      prefs.setString('userData', userData);
      print(responsedata['email']);
      print(responsedata['localId']);
    } catch (e) {
      //throw e;
      print(e);
    }
  }
}
