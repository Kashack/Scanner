import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:scanner_attendance/data/http_api.dart';
import 'package:scanner_attendance/presentation/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  final String email;

  OtpPage({required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? otpPin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OTP',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text('Enter the code that was sent to your email'),
                  PinCodeTextField(
                    appContext: context,

                    length: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your OTP';
                      }
                    },
                    cursorColor: Colors.green,
                    onChanged: (value) => otpPin = value,
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.restart_alt),
                    onPressed: () {},
                    label: Text(
                      'Resend',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await HTTPApi()
                              .LoginVerification(
                                  otp: otpPin!, email: widget.email)
                              .then((value) async {
                            if (value['successful'] == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(value['errorMessage'])));
                            } else {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              await pref.setBool('isLogin', true);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                                (route) => false,
                              );
                            }
                          }).whenComplete(() {
                            setState(() {
                              _isLoading = false;
                            });
                          }).catchError((err) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: No Network')));
                          });
                        }
                      },
                      style: OutlinedButton.styleFrom(),
                      child: Text(
                        'Next >>',
                        style: TextStyle(
                          color: Color(0xFF006600),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black12,
              ),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
