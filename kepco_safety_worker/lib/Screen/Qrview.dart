import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qrview extends StatefulWidget {
  const Qrview({Key? key}) : super(key: key);

  @override
  State<Qrview> createState() => _QrviewState();
}

class _QrviewState extends State<Qrview> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            child: QRView(
              key: qrKey,
              onQRViewCreated: this._onQRViewCreated,
              formatsAllowed: [BarcodeFormat.qrcode],
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Colors.blue,
                borderLength: 30,
                borderWidth: 5,
                cutOutSize: MediaQuery.of(context).size.width / 1.4,
              ),
            ),
          ),
        )
      ],
    ));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller!.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (scanData.code != null) {
          this.controller!.dispose();
          Navigator.pop(context, scanData.code);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
