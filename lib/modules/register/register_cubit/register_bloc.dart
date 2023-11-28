import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_off : Icons.visibility;
    emit(PasswordVisibilityState());
  }


  LoginModel? registerData;

  userRegister ({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name'   : name,
          'email'   : email,
          'password': password,
          'phone'   : phone,
        }
    )?.then((value){
      registerData = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(registerData!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}