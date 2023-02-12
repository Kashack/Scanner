import 'package:flutter/material.dart';
import 'package:scanner_attendance/presentation/sign_in_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Text(
              'Hi,\nWelcome',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                  color: Color(0xFF006600)),
            ),
            Expanded(
              child: SizedBox(
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ));
                },
                style: OutlinedButton.styleFrom(),
                child: Text(
                  'Next >>',
                  style: TextStyle(
                    color: Color(0xFF006600),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
