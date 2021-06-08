import 'dart:async';

import 'package:bull_run/app/shared/colors.dart';
import 'package:bull_run/app/shared/dimensions.dart';
import 'package:bull_run/meta/views/auth/login_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupView extends StatelessWidget {
  final nameController = TextEditingController();

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EvaIcons.arrowIosBackOutline,
                        color: whiteColor,
                      ))
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hey there!",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: whiteColor),
                  ).shimmer(
                    primaryColor: Vx.red200,
                    secondaryColor: Colors.white,
                    duration: Duration(seconds: 3)
                  ),
                  Text(
                    "Welcome to the Bull Run",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: whiteColor),
                  ),
                  Text(
                    "Fill in your details.",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: whiteColor),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  vSizedBox1,
                  stylishTextField("Name", nameController),
                  vSizedBox1,
                  stylishTextField("Email", emailController),
                  vSizedBox1,
                  stylishTextField("Password", passwordController),
                ],
              ),
            ),
            vSizedBox2,
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                          )),
                      TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: LoginView(),
                                      type: PageTransitionType.rightToLeft));
                            },
                          style: TextStyle(
                            fontSize: 18,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ))
                    ])),
                    vSizedBox2,
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  stylishTextField(String text, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(color: whiteColor, fontSize: 18),
      decoration: new InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                EvaIcons.backspace,
                color: textColor,
              )),
          filled: true,
          hintText: text,
          hintStyle: TextStyle(fontSize: 14, color: textColor),
          fillColor: bgColor,
          border: new OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(const Radius.circular(15)))),
    );
  }
}
