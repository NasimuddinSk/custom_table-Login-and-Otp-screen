import 'package:custom_table/pages/login_demo/pages/login_page.dart';
import 'package:custom_table/pages/login_demo/pages/otp_page3.dart';
import 'package:custom_table/pages/login_demo/pages/otp_page4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfff2f2f2),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xfff2f2f2)),
      ),
      debugShowCheckedModeBanner: false,
      home: OtpPage4(),
    );
  }
}
