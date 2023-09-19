import 'package:flutter/material.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Container(color: Colors.red),),
            Expanded(child: Container(color: Colors.green),),
            Expanded(child: Container(color: Colors.amber),)
          ],
        ),
      ),
    );
  }
}