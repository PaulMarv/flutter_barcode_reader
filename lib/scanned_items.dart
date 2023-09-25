import 'package:flutter/material.dart';
import 'package:flutter_qrcode_reader/models/ItemModel.dart';

class ScannedItems extends StatefulWidget {
  final List itemList;

  const ScannedItems({super.key, required this.itemList});

  @override
  State<ScannedItems> createState() => _ScannedItemsState();
}

class _ScannedItemsState extends State<ScannedItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.itemList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ElevatedButton(
              onPressed: () {},
              child: const Text('View item'),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            ),
            title: Text("Item ${index + 1}"),
            subtitle: const Text('1 Qty'),
          );
        });
  }
}
