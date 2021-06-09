import 'package:bull_run/app/shared/colors.dart';
import 'package:bull_run/app/shared/dimensions.dart';
import 'package:bull_run/meta/utils/routs.dart';
import 'package:bull_run/meta/views/auth/signup_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends StatelessWidget {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: darkColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          EvaIcons.arrowIosForwardOutline,
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
                      "Lets sign you in.",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: whiteColor),
                    ),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: whiteColor),
                    ).shimmer(
                        primaryColor: Vx.pink300, secondaryColor: Colors.white),
                    Text(
                      "You've been missed!",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: whiteColor),
                    ),
                  ],
                ),
              ),
              vSizedBox1,
              Container(
                child: Column(
                  children: [
                    vSizedBox1,
                    stylishTextField("Email", emailController),
                    vSizedBox1,
                    stylishTextField("Password", passwordController),
                  ],
                ),
              ),
              vSizedBox4,
              InkWell(
                onTap: (){
                  
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: "Montserrat",
                              )),
                          TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, MyRouts.signupRoute);
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
                              "Login",
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  stylishTextField(String text, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      obscureText: text == "Password" ? true : false,
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
