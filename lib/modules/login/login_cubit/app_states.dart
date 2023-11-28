import 'package:shop_app/models/login_model.dart';

abstract class AppStates{}

class InitialState extends AppStates{}

class PasswordVisibilityState extends AppStates{}

class LoginLoadingState extends AppStates{}

class LoginSuccessState extends AppStates{
  final LoginModel loginData;
  LoginSuccessState(this.loginData);
}

class LoginErrorState extends AppStates{
  final String error;
  LoginErrorState(this.error);
}