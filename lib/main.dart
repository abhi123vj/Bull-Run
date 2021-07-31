import 'package:bull_run/Screens/home_screen.dart';
import 'package:bull_run/Screens/splash_screen.dart';
import 'package:bull_run/Screens/unknown_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
    WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
       debugShowCheckedModeBanner: false,
       initialRoute: '/',
        unknownRoute: GetPage(name: '/notfound', page: () => UnknownScreen()),
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),

          // GetPage(
          //   name: '/home',
          //   page: () => HomeView(),
          //   transition: Transition.zoom
          // ),
        ],
    );
  }
}
