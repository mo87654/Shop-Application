import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginModel? userModel = ShopCubit.get(context).userModel;
          if(userModel?.data != null)
            {
              nameController.text = userModel!.data!.name!;
              emailController.text = userModel.data!.email!;
              phoneController.text = userModel.data!.phone!;
            }
          return userModel == null?
            Center(child: CircularProgressIndicator(),)
            :SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    if(state is UpdateUserDataLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 12,
                    ),
                    CircleAvatar(
                      radius: 60,
                      child: Image(
                        image: NetworkImage('${userModel.data?.image}'),
                        errorBuilder: (context, error, stackTrace) {

                          return Center(child: CircularProgressIndicator(),);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defaultTextField(
                      controller: nameController,
                      label: 'Name',
                      prefix: Icons.person,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      validFunction: (value){
                        if(value.isEmpty)
                        {
                          return 'Name is required';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                      controller: emailController,
                      label: 'Email',
                      prefix: Icons.email,
                      inputType: TextInputType.emailAddress,
                      validFunction: (value){
                        if(value.isEmpty)
                        {
                          return 'Email is required';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                      controller: phoneController,
                      label: 'Phone',
                      prefix: Icons.phone_android,
                      inputType: TextInputType.phone,
                      validFunction: (value){
                        if(value.isEmpty)
                        {
                          return 'Phone is required';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        text: 'UPDATE',
                        pressFunction: (){
                          if(formKey.currentState!.validate())
                            {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                             if(userModel.message != null)
                               {
                                 if(userModel.data != null)
                                 {
                                   toastMessage(message: userModel.message!, color: Colors.green);
                                 }else
                                 {
                                   toastMessage(message: userModel.message!, color: Colors.red);
                                 }
                               }
                            }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        text: 'LOG OUT',
                        pressFunction: (){
                          CachHelper.removeData(key: 'token').then((value){
                            if(value!) {
                              navigateToAndReplace(context, LoginScreen());
                              ShopCubit.get(context).currentIndex = 0;
                            }
                          }).catchError((error){
                            print(error.toString());
                          });
                        }
                    )
                  ],
                ),
              ),
          ),
            );
        },
    );
  }
}
