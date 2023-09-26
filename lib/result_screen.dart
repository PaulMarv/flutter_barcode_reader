import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qrcode_reader/models/ItemModel.dart';
import 'package:flutter_qrcode_reader/qr_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
  final int index;
  final ItemModel item;

  const ResultScreen({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black87,
        ),
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Item ${index + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),),
            const SizedBox(
              height: 5,
            ),
            Text('Quantity: ${item.quantity}',
              style: const TextStyle(

                fontSize: 12
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //QR CODE HERE
            QrImageView(
              data: item.qrCode,
              size: 150,
              version: QrVersions.auto,
            ),

            const Text(
              'Scanned result',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              item.qrCode,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black87, fontSize: 16, letterSpacing: 1),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: item.qrCode),
                  );
                },
                child: const Text(
                  'Copy',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
