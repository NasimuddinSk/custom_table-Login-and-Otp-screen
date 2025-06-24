import 'dart:async';

import 'package:custom_table/pages/login_demo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

class OtpPage4 extends StatefulWidget {
  const OtpPage4({super.key});

  @override
  State<OtpPage4> createState() => _OtpPage4State();
}

class _OtpPage4State extends State<OtpPage4>
    with SingleTickerProviderStateMixin {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _timer = 0;
  final int _finalSecound = 60 * 5;
  Timer? resendTime;
  bool isTimerRunning = false;

  String? _otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Required OTP";
    } else if (value == "00000" && value.length == 5) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      return "Invalid OTP";
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    formKey.currentState!.validate();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void resendTimer() {
    resendTime?.cancel();
    _timer = _finalSecound;

    resendTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _timer = _finalSecound;
          isTimerRunning = false;

          resendTime!.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    final formatter = NumberFormat("00");
    return "${formatter.format(minutes)}:${formatter.format(remainingSeconds)}";
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff551C8B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mq.height * 0.08),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/otp.png",
                    width: 55,
                    height: 55,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.01),

            Text(
              "OTP",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                textAlign: TextAlign.center,
                "If you did not receive the OTP, please check your spam folder or try again.",
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              ),
            ),
            SizedBox(height: mq.height * 0.01),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                textAlign: TextAlign.center,
                "demo512@gmail.com, evidya520@gmail.com, demo512@gmail.com",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: mq.height * 0.07),
            Container(
              width: mq.width,
              height: mq.height * .60,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      errorBuilder:
                          (errorText, pin) => Text(
                            errorText ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      separatorBuilder: (index) {
                        return SizedBox(width: mq.width * .03);
                      },
                      controller: pinController,
                      focusNode: focusNode,

                      validator: _otpValidator,
                      length: 5,
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: mq.height * 0.07),

                    isTimerRunning
                        ? Text(
                          "Resend in ${formatTime(_timer)}s",
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                        : Column(
                          children: [
                            Text(
                              "Don't recevied OTP ?",
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: mq.height * 0.01),

                            InkWell(
                              onTap: () {
                                resendTimer();
                                isTimerRunning = true;
                              },
                              child: Text(
                                "Resend OTP",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                    SizedBox(height: mq.height * 0.07),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xff551C8B),
                        foregroundColor: Colors.white,
                        minimumSize: Size(mq.width * .6, mq.height * .05),
                      ),
                      onPressed: _submit,
                      child: Text(
                        "Submit",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
