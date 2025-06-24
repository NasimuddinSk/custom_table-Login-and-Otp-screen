import 'dart:async';

import 'package:custom_table/pages/login_demo/pages/home_page.dart'
    show HomePage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpPage2 extends StatefulWidget {
  const OtpPage2({super.key});

  @override
  State<OtpPage2> createState() => _OtpPage2State();
}

class _OtpPage2State extends State<OtpPage2>
    with SingleTickerProviderStateMixin {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _timer = 15;
  Timer? resendTime;
  bool isTimerRunning = true;
  late AnimationController _controller;

  @override
  void initState() {
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _timer),
    )..forward(); // start animation
    resendTimer();

    super.initState();
  }

  // void _restartAnimation() {
  //   _controller.reset(); // stop and rewind
  //   _controller.forward(from: 0); // restart from 0
  // }

  void resendTimer() {
    resendTime?.cancel();
    _timer = 15;
    _controller.reset(); // stop and rewind
    _controller.forward(from: 0); // restart from 0
    resendTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _timer = 15;
          isTimerRunning = false;
          _controller.reset(); // stop and rewind
          _controller.forward(from: 0); // restart from 0
        }
      });
    });
  }

  String? _otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Required OTP";
    } else if (value == "0000" && value.length == 4) {
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
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const focusedBorderColor = Colors.blue;
    // const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const fillColor = Color.fromARGB(255, 20, 153, 255);
    const borderColor = Color.fromARGB(255, 3, 128, 230);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,

      textStyle: GoogleFonts.timmana(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      /// Optionally you can use form to validate the Pinput
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "OTP Verification",
                  style: GoogleFonts.oleoScript(fontSize: 50),
                ),
                Text(
                  "Enter the verification code send on the\nEmail address you entered.",
                  style: GoogleFonts.timmana(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323232),
                  ),
                ),
                Text(
                  "nasimuddinsk15@gmail.com",
                  style: GoogleFonts.timmana(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pinput(
                          // You can pass your own SmsRetriever implementation based on any package
                          // in this example we are using the SmartAuth
                          // onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          errorTextStyle: GoogleFonts.timmana(
                            color: Colors.redAccent,
                          ),
                          controller: pinController,
                          focusNode: focusNode,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder:
                              (index) => const SizedBox(width: 10.0),
                          validator: _otpValidator,
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: Color.fromARGB(255, 20, 153, 255),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: GoogleFonts.timmana(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(flex: isTimerRunning ? 3 : 1),
                        isTimerRunning
                            ? AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return ShaderMask(
                                  shaderCallback: (bounds) {
                                    return LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [
                                        _controller.value,
                                        _controller.value + 0.001,
                                      ],
                                      colors: [
                                        Colors.blue, // Filled part
                                        Color(0xff323232), // Unfilled part
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(
                                        0,
                                        0,
                                        bounds.width,
                                        bounds.height,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Resend in ${_timer}s",
                                    style: GoogleFonts.timmana(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),

                                    // TextStyle(
                                    //   fontSize: 20,
                                    //   fontWeight: FontWeight.bold,
                                    //   color: Colors.white,
                                    // ),
                                  ),
                                );
                              },
                            )
                            : Row(
                              children: [
                                Text(
                                  "If you didn't recive a code! ",
                                  style: GoogleFonts.timmana(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff323232),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // _restartAnimation();

                                    resendTimer();
                                    isTimerRunning = true;
                                  },
                                  child: Text(
                                    "Resend OTP",
                                    style: GoogleFonts.timmana(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[500],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(flex: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff323232),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _submit,
                          child: Text("Verify", style: GoogleFonts.timmana()),
                        ),
                        Spacer(),
                      ],
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
