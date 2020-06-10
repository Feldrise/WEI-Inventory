import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory/pages/inventory_page/inventory_page.dart';
import 'package:wei_inventory/providers/inventory_store.dart';
import 'package:wei_inventory/utils/colors_utils.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({Key key, @required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryStore>(
      builder: (context, inventory, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: inventory,
                  child: InventoryPage(),
                )
              )
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                left: BorderSide(
                  color: randomMaterialColor(),
                  width: 5,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 3.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal
                    5.0, // vertical
                  ),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("#$index", style: Theme.of(context).textTheme.headline2,),
                const SizedBox(width: 24,),
                Expanded(
                  child: Text(inventory.name, style: Theme.of(context).textTheme.headline2,),
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        );
      },
    );
  }
  
}