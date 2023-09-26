import 'package:flutter/material.dart';
import 'package:flutter_qrcode_reader/models/ItemModel.dart';

import 'package:flutter_qrcode_reader/scanned_items.dart';
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
  List<ItemModel> itemModels = [];


  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  void closeScreen() {
    isScanCompleted = false;
  }

  bool isValuePresent(List<ItemModel> itemModels, String code) {
    for (var item in itemModels) {
      if (item.qrCode == code) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.blue);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front, color: Colors.blue);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear, color: Colors.grey);
                }
              },
            ),
            onPressed: () => cameraController.switchCamera(),
          )
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
            const Column(
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
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
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
                                startDelay: true,
                                controller: cameraController,
                                onDetect: (capture) {
                                  final List<Barcode> barcodes =
                                      capture.barcodes;

                                  for (final barcode in barcodes) {
                                    String code = barcode.rawValue ?? '---';

                                    bool containsValue =
                                        isValuePresent(itemModels, code);

                                    if (containsValue) {
                                      return;
                                    } else {
                                      setState(() {
                                        itemModels.add(ItemModel(
                                          qrCode: code,
                                          quantity: 1,
                                          
                                        ));
                                      });
                                    }

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => ResultScreen(
                                    //       closeScreen: closeScreen,
                                    //       code: code,
                                    //     ),
                                    //   ),
                                    // );
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: ScannedItems(itemList: itemModels)),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Developed by Paul',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
