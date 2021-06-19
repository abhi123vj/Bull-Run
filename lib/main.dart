import 'package:bull_run/meta/model/trades.dart';
import 'package:bull_run/meta/utils/routs.dart';
import 'package:bull_run/meta/views/auth/login_view.dart';
import 'package:bull_run/meta/views/auth/signup_view.dart';
import 'package:bull_run/meta/views/home_screen/home_header_helper.dart';
import 'package:bull_run/meta/views/home_screen/home_view.dart';
import 'package:bull_run/meta/views/home_screen/homeview_helper.dart';
import 'package:bull_run/meta/views/splash_screen/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String dataBoxName = "data3";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  
  Hive.registerAdapter(TradesAdapter());
  await Hive.openBox<Trades>(dataBoxName);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'Montserrat', canvasColor: Colors.transparent),
          routes: {
            "/": (context) => SplashView(),
            MyRouts.loginRoute: (context) => LoginView(),
            MyRouts.signupRoute: (context) => SignupView(),
            MyRouts.homeRoute: (context) => MyHomePage(),
          },
        ),
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeHelper(),
          ),
           ChangeNotifierProvider(
            create: (_) => HomeHeaderHelper(),
          ),
        ]);
  }
}
