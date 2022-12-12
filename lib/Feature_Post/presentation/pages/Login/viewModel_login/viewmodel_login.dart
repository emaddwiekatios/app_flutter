

import 'dart:async';

import 'package:clean_arch_app/Feature_Post/presentation/base/BaseViewModel.dart';

import '../../../../domain/entities/Models.dart';

class LoginViewModel  extends BaseViewModel with LoginViewModelInput,LoginViewModelOutput
{
 final  StreamController<String> _streamControllerUserName =StreamController<String>.broadcast();
 final  StreamController<String> _streamControllerPassword =StreamController<String>.broadcast();
 final  StreamController<String> _streamControllerLoginButton =StreamController<String>.broadcast();

 var userNameLogin="";
 var passwordLogin="";

 @override
  void dispose() {
    _streamControllerUserName.close();
    _streamControllerPassword.close();
    _streamControllerLoginButton.close();
  }

  @override
  void start() {
  }

  @override
  Sink<String> get getLoginViewModelInputUserName => _streamControllerUserName.sink;


  @override
  Stream<bool> get getLoginViewModelOutUserName => _streamControllerUserName.stream.map((userName) => isUserNameValid(userName));


  bool isUserNameValid(String userName)
     {
   return userName.isNotEmpty;
     }

 bool isPasswordValid(String password)
    {
   return password.isNotEmpty;
     }

  @override
  setUserName(String userName) {
    getLoginViewModelInputUserName.add(userName);
    userNameLogin =userName;

    getLoginViewModelInputLoginButton.add("");
  }


 @override
 setPassword(String password) {
   getLoginViewModelInputPassword.add(password);
   passwordLogin =password;
   getLoginViewModelInputLoginButton.add("");
 }

  @override
  Sink<String> get getLoginViewModelInputPassword => _streamControllerPassword.sink;

  @override
  Stream<bool> get getLoginViewModelOutPassword => _streamControllerPassword.
  stream.map((password) => isPasswordValid(password));

  @override
  // TODO: implement getLoginViewModelInputLoginButton
  Sink<String> get getLoginViewModelInputLoginButton
  => _streamControllerLoginButton.sink;



bool isLoginButtonValid(String userName,String password)
{
  print('userNameLogin  =${userNameLogin}');
  print('passwordLogin pass=${passwordLogin}');


  print('isLoginButtonValid user =${userName}');
  print('isLoginButtonValid pass=${password}');
  return  userName.isNotEmpty && password.isNotEmpty;
}

  @override
  // TODO: implement getLoginViewModelOutLoginButton
  Stream<bool> get getLoginViewModelOutLoginButton =>
      _streamControllerLoginButton.
      stream.map((_) => isLoginButtonValid(userNameLogin,passwordLogin));



}
abstract class LoginViewModelInput
{
  setUserName(String userName);
  setPassword(String password);
  Sink<String> get getLoginViewModelInputUserName;
  Sink<String> get getLoginViewModelInputPassword;
  Sink<String> get getLoginViewModelInputLoginButton;
}

abstract class LoginViewModelOutput
{
  Stream<bool> get getLoginViewModelOutUserName;
  Stream<bool> get getLoginViewModelOutPassword;
  Stream<bool> get getLoginViewModelOutLoginButton;
}