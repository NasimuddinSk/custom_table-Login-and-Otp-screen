import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

class OtpPage3 extends StatefulWidget {
  const OtpPage3({super.key});

  @override
  State<OtpPage3> createState() => _OtpPage3State();
}

class _OtpPage3State extends State<OtpPage3>
        // For animation add with SingleTickerProviderStateMixin -------------------------------------------------------
        with
        SingleTickerProviderStateMixin {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _timer = 0;
  final int _finalSecound = 30;
  Timer? resendTime;
  bool isTimerRunning = true;
  late AnimationController _controller;

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    final formatter = NumberFormat("00");
    return "${formatter.format(minutes)}:${formatter.format(remainingSeconds)}";
  }

  @override
  void initState() {
    // For animation -----------------------------------------
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _finalSecound),
    )..forward(); // start animation
    resendTimer();

    super.initState();
  }

  void resendTimer() {
    resendTime?.cancel();
    _timer = _finalSecound;
    _controller.reset(); // stop and rewind
    _controller.forward(from: 0); // restart from 0
    resendTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _timer = _finalSecound;
          isTimerRunning = false;
          _controller.reset(); // stop and rewind
          _controller.forward(from: 0); // restart from 0
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: mq.height * .2),
                Text(
                  "Verify OTP",
                  style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Verify OTP send on your entered E-main address",
                  maxLines: 2,
                  style: GoogleFonts.inter(fontSize: 15, color: Colors.black87),
                ),
                Text(
                  "sna******51@gmail.com",
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: mq.height * .08),
                Pinput(
                  separatorBuilder: (index) => const SizedBox(width: 8.0),
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(65, 96, 96, 96),
                      border: Border.all(
                        color: const Color.fromARGB(106, 96, 96, 96),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: mq.height * .015),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),

                    isTimerRunning
                        // For animation of left to right -----------------------------------------
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
                                    Colors.blueAccent, // Filled part
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
                                "Resend in ${formatTime(_timer)}s",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
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
                              style: GoogleFonts.inter(
                                fontSize: 10,
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
                                style: GoogleFonts.inter(
                                  fontSize: 14,
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
              ],
            ),
          ),
          SizedBox(height: mq.height * .03),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff323232),
              foregroundColor: Colors.white,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: Size(mq.width * .45, mq.height * 0.04),
            ),
            onPressed: () {},
            child: Text(
              "Verify",
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(flex: 5),
          Text(
            textAlign: TextAlign.center,
            "Please check your spam forder if not showing email in Inbox",
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              wordSpacing: 2,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
