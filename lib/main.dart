import 'package:bull_run/meta/utils/routs.dart';
import 'package:bull_run/meta/views/auth/login_view.dart';
import 'package:bull_run/meta/views/auth/signup_view.dart';
import 'package:bull_run/meta/views/home_screen/home_view.dart';
import 'package:bull_run/meta/views/splash_screen/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: {
        "/": (context) => SplashView(),
        MyRouts.loginRoute: (context) => LoginView(),
        MyRouts.signupRoute: (context) => SignupView(),
        MyRouts.homeRoute: (context) => HomeView(),
      },
    );
  }
}
