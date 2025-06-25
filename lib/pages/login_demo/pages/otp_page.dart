import 'package:custom_table/pages/login_demo/pages/home_page.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  final _focus1 = FocusNode();
  final _focus2 = FocusNode();
  final _focus3 = FocusNode();

  @override
  void dispose() {
    // Always dispose focus nodes and controllers!
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();

    _focus1.dispose();
    _focus2.dispose();
    _focus3.dispose();
    super.dispose();
  }

  String? _otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Verify this mobile number",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[500],
              ),
            ),
          ),
          const Center(
            child: Text(
              "End with: +91xxxxxxxx85",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOtpBox(
                      controller: _controller1,
                      currentFocus: _focus1,
                      nextFocus: _focus2,
                      previousFocus: null,
                    ), // first
                    const SizedBox(width: 10),
                    _buildOtpBox(
                      controller: _controller2,
                      currentFocus: _focus2,
                      nextFocus: _focus3,
                      previousFocus: _focus1,
                    ), // second
                    const SizedBox(width: 10),
                    _buildOtpBox(
                      controller: _controller3,
                      currentFocus: _focus3,
                      nextFocus: null,
                      previousFocus: _focus2,
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox({
    required TextEditingController controller,
    required FocusNode currentFocus,
    FocusNode? nextFocus,
    FocusNode? previousFocus,
  }) {
    return SizedBox(
      width: 55,
      child: TextFormField(
        showCursor: false,
        validator: _otpValidator,
        controller: controller,
        focusNode: currentFocus,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          counterText: '', // hides "0/1"
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(19)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus();
            }
          } else {
            // if user pressed backspace on an empty field
            if (previousFocus != null) {
              FocusScope.of(context).requestFocus(previousFocus);
            }
          }
        },
      ),
    );
  }
}
