import 'package:custom_table/pages/login_demo/pages/otp_page4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff2f2f2),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xfff2f2f2)),
      ),
      debugShowCheckedModeBanner: false,
      home: const OtpPage4(),
    );
  }
}
