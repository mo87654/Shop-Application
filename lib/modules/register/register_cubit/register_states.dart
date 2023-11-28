import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class PasswordVisibilityState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final LoginModel registerData;
  RegisterSuccessState(this.registerData);
}

class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}