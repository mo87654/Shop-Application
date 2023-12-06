import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_cubit/register_bloc.dart';
import 'package:shop_app/modules/register/register_cubit/register_states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state){
          if(state is RegisterSuccessState)
          {
            if(state.registerData.status!)
            {
              CachHelper.savaData(key: 'token', value: state.registerData.data?.token).
              then((value){
                token = state.registerData.data?.token;
                navigateToAndReplace(context,ShopLayout());

              });
              toastMessage(
                message: state.registerData.message!,
                color: Colors.green,
              );
            }else
            {
              toastMessage(
                message: state.registerData.message!,
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register and brows our amazing offers',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        defaultTextField(
                            label: 'Name',
                            controller: nameController,
                            prefix: Icons.person_outline,
                            inputType: TextInputType.name,
                            inputAction: TextInputAction.next,
                            validFunction: (value){
                              if(value.isEmpty)
                              {
                                return 'Enter your Name';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20,
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
                            inputAction: TextInputAction.next,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixFunction: (){
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            validFunction: (value){
                              if(value.isEmpty)
                              {
                                return 'Enter your Password';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            label: 'Phone',
                            controller: phoneController,
                            prefix: Icons.phone_android_outlined,
                            inputType: TextInputType.phone,
                            inputAction: TextInputAction.done,
                            validFunction: (value){
                              if(value.isEmpty)
                              {
                                return 'Enter your phone number';
                              }
                            }
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (state is! RegisterLoadingState)?
                        defaultButton(
                          text: 'REGISTER',
                          pressFunction: (){
                            if(formkey.currentState!.validate())
                            {
                              RegisterCubit.get(context).userRegister(
                                  name   : nameController.text,
                                  email   : emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
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
                              'Have an account?',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context, LoginScreen());
                                },
                                child: const Text(
                                  'Login',
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