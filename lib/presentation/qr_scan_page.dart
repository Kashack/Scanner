import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanPage extends StatelessWidget {
  MobileScannerController? _controller;
  String? CourseCode;
  String? CourseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
          allowDuplicates: false,
          controller: MobileScannerController(
          ),
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final List code = barcode.rawValue! as List;
              print(code);
            }
          }),
    );
  }
}
