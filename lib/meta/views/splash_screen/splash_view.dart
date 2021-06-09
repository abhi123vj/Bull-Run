import 'dart:async';
import 'package:bull_run/app/shared/colors.dart';
import 'package:bull_run/meta/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, MyRouts.signupRoute));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "TRADERS",
              style: TextStyle(
                  fontSize: 50, fontWeight: FontWeight.w900, color: whiteColor),
            ).shimmer(
                primaryColor: Vx.cyan100,
                secondaryColor: Colors.white,
                duration: Duration(seconds: 1)),
                 Text(
              " JOURNAL",
              style: TextStyle(
                  fontSize: 50, fontWeight: FontWeight.w900, color: whiteColor),
            ).shimmer(
                primaryColor: Vx.blue100,
                secondaryColor: Colors.white,
                duration: Duration(seconds: 1)),
          ],
        ),
      ),
    );
  }
}
