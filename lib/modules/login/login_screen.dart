import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_cubit/app_cubit.dart';
import 'package:shop_app/modules/login/login_cubit/app_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is LoginSuccessState)
            {
              if(state.loginData.status!)
                {
                  CachHelper.savaData(key: 'token', value: state.loginData.data?.token).
                  then((value){
                    token = state.loginData.data?.token;
                    navigateToAndReplace(context,ShopLayout());

                  });
                  toastMessage(
                    message: state.loginData.message!,
                    color: Colors.green,
                  );
                }else
                  {
                    toastMessage(
                      message: state.loginData.message!,
                      color: Colors.red,
                    );
                  }
            }
        },
        builder: (context, state){
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login and brows our amazing offers',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        defaultTextField(
                          label: 'Email',
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          validFunction: (value){
                              if(value.isEmpty)
                              {
                                return 'Enter your Email';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          inputType: TextInputType.visiblePassword,
                          submitFunction: (value){
                            if(formkey.currentState!.validate())
                            {
                              AppCubit.get(context).userLogin(
                                  email   : emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          isPassword: AppCubit.get(context).isPassword,
                          suffix: AppCubit.get(context).suffix,
                          suffixFunction: (){
                            AppCubit.get(context).changePasswordVisibility();
                          },
                          validFunction: (value){
                            if(value.isEmpty)
                              {
                                return 'Enter your Password';
                              }
                          }
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (state is! LoginLoadingState)?
                        defaultButton(
                            text: 'LOGIN',
                            pressFunction: (){
                              if(formkey.currentState!.validate())
                              {
                                AppCubit.get(context).userLogin(
                                    email   : emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },

                        ):Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
