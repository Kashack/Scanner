import 'package:flutter/material.dart';
import 'package:scanner_attendance/presentation/main_page.dart';
import 'package:scanner_attendance/presentation/sign_in_screen.dart';
import 'package:scanner_attendance/presentation/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? initScreen = true;
bool? isLogin = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getBool('isFirstTime');
  isLogin = await prefs.getBool('isLogin');
  await prefs.setBool('isFirstTime', false);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE2FFE2),
          appBarTheme: AppBarTheme(
              color: Color(0xFFE2FFE2),
              elevation: 0,
              iconTheme: IconThemeData(
                  color: Colors.black
              )
          )
      ),
      home: initScreen == true || initScreen == null ?
      WelcomePage(): isLogin == false || isLogin == null ? SignInPage() : MainPage(),
    );
  }
}