import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onBoarding/onboarding_screen.dart';
import 'package:shop_app/shared/component/colors.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  Widget startWidget;
  bool? onBoarding = CachHelper.getData(key: 'onBoarding');
  token = CachHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      startWidget = ShopLayout();
    else
      startWidget = LoginScreen();
  } else {
    startWidget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
            )
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: defaultColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(
            size: 25
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12
          ),
          unselectedIconTheme: IconThemeData(
              size: 25
          ),
          unselectedLabelStyle:  TextStyle(
              fontSize: 12
          ),
        )
      ),
      title: 'My Fucking App',
      home: startWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
