import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/login_cubit/app_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_off : Icons.visibility;
    emit(PasswordVisibilityState());
  }


  LoginModel? loginData;
  userLogin ({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email'   : email,
          'password': password
        }
    )?.then((value){
      loginData = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginData!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}