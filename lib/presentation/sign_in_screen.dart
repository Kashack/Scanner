import 'package:flutter/material.dart';
import 'package:scanner_attendance/data/http_api.dart';
import 'package:scanner_attendance/presentation/otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? email;
  bool _isLoading = false;
  String? password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Email address';
                        }
                      },
                    ),
                    Expanded(
                      child: SizedBox(),
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
                                .LectureLogin(email!)
                                .then((value) async {
                              if (value['successful'] == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(value['errorMessage'])));
                              } else {
                                Map result = value['result'];
                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                await pref.setString('lectureName',
                                    '${result['firstName']},${result['lastName']}');
                                await pref.setString(
                                    'lectureId', result['id']);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtpPage(email: email!,),
                                    ),(route) => false,);
                              }
                            }).whenComplete(() {
                              setState(() {
                                _isLoading = false;
                              });
                            }).catchError((err) {
                              print('No Network');
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
