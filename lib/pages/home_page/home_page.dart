import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory/pages/home_page/widgets/inventory_card.dart';
import 'package:wei_inventory/providers/inventories_store.dart';
import 'package:wei_inventory/providers/inventory_store.dart';
import 'package:wei_inventory/shared/dialogs/inventory_name.dart';
import 'package:wei_inventory/shared/screen_title.dart';
import 'package:wei_inventory/shared/widgets/bottom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoriesStore>(
      builder: (context, inventoriesStore, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ScreenTitle(title: "Stock"),
                FutureBuilder(
                  future: inventoriesStore.inventories,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return const Text("Une erreur est survenue...");
                    }

                    final List<InventoryStore> inventories = snapshot.data as List<InventoryStore>;

                    return Expanded(
                      child: ListView.builder( 
                        shrinkWrap: true,
                        itemCount: inventories.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: inventories[index],
                            child: InventoryCard(index: index + 1,),
                          );
                        },
                      )
                    );
                  },
                ),
                BottomButton(
                  onPressed: () async => _addInventory(context, inventoriesStore),
                  icon: Icons.add,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future _addInventory(BuildContext context, InventoriesStore inventoriesStore) async {
    final String newInventoryName = await inventoryNameDialog(context); 

    if (newInventoryName != null && newInventoryName.isNotEmpty) {
      inventoriesStore.addNewInventory(newInventoryName);
    }
  }

}