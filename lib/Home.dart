import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String qrCode = "";
  double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width / 100;
    height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: height * 5,
              width: width * 40,
              alignment: Alignment.center,
              child: Text(
                "Scan Result",
                style: TextStyle(
                  fontSize: height * 1.7,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: height),
            Text(
              '$qrCode',
              style: TextStyle(
                  fontSize: height * 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: height * 20),
            InkWell(
              onTap: () {
                scanQRCode();
              },
              child: Container(
                  width: width * 40,
                  height: height * 5,
                  color: Colors.lightBlue,
                  alignment: Alignment.center,
                  child: Text(
                    'Start Scan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 1.6,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
