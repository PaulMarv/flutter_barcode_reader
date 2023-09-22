import 'package:flutter/material.dart';
import 'package:flutter_qrcode_reader/result_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;

  MobileScannerController cameraController = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                if (isFlashOn) {
                  cameraController.toggleTorch();
                }
              },
              icon: Icon(Icons.flash_on, color: isFlashOn? Colors.blue : Colors.grey)),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                if (isFrontCamera) {
                  cameraController.switchCamera();
                }
              },
              icon:Icon(Icons.camera_front, color: isFlashOn? Colors.blue: Colors.grey))
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          'QR Scanner',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Column(
                children: [
                  Text(
                    'Place the QR code in the area',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Scanning will be started automatically',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 280,
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: MobileScanner(
                                  controller: cameraController,
                                  onDetect: (capture) {
                                    if (!isScanCompleted) {
                                      final List<Barcode> barcodes =
                                          capture.barcodes;
                                      for (final barcode in barcodes) {
                                        String code = barcode.rawValue ?? '---';
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ResultScreen(
                                              closeScreen: closeScreen,
                                              code: code,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }),
                            ),
                          ),
                        ),
                        QRScannerOverlay(
                          borderColor: Colors.blue,
                          overlayColor: bgColor,
                          scanAreaHeight: 300,
                          scanAreaWidth: 300,
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Developed by Paul',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
