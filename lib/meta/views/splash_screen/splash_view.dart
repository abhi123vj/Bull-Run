import 'dart:async';
import 'package:bull_run/app/shared/colors.dart';
import 'package:bull_run/meta/utils/routs.dart';
import 'package:bull_run/meta/views/auth/login_view.dart';
import 'package:bull_run/meta/views/auth/signup_view.dart';
import 'package:bull_run/meta/views/home_screen/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

final bool islogged = false;

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, MyRouts.landingPage));
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

// bool LandingPage() {
//   FirebaseAuth.instance.currentUser().then((firebaseUser) {
//     if (firebaseUser == null) {
//       return islogged == false;
//     } else {
//       return islogged == true;
//     }
//   });
// }
class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _intialization,
        builder: (context, snapshot) {
          // if (islogged == true) {
          //   return MyHomePage();
          // }
          // if (islogged == false) {
          //   return SignupView();
          // }
          // Once complete, show your application
          //if (snapshot.connectionState == ConnectionState.done) {
          FirebaseAuth auth = FirebaseAuth.instance;
          FirebaseAuth.instance.userChanges().listen((User? user) async {
            await Firebase.initializeApp();
            if (user == null) {
              //print('User is signed out!');
              return loginnot();
            } else {
              return loginfound();
            }
          });
          // Check for errors
          if (snapshot.hasError) {
            print("error found");
          }
          // }
          print("returnd error");
          return Scaffold(
            body: Center(
              child: Text("error out in user found"),
            ),
          );
          // Otherwise, show something whilst waiting for initialization to complete
          //return LoginView();
        });
  }
}

void loginfound() {
  islogged == true;
}

void loginnot() {
  islogged == false;
}
