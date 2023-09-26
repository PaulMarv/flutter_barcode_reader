import 'package:flutter/material.dart';
import 'package:flutter_qrcode_reader/models/ItemModel.dart';
import 'package:flutter_qrcode_reader/result_screen.dart';

class ScannedItems extends StatefulWidget {
  final List<ItemModel> itemList;

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      index:index,
                      item: widget.itemList[index]
                    ),
                  ),
                );
              },
              child: const Text('View item'),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.itemList[index].quantity >= 1) {
                          widget.itemList[index].quantity--;
                        }
                        return;
                      });
                    },
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.itemList[index].quantity++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            ),
            title: Text("Item ${index + 1}"),
            subtitle: Text('${widget.itemList[index].quantity} qty'),
          );
        });
  }
}
