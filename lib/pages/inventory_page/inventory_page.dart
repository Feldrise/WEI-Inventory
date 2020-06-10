import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory/pages/inventory_page/widgets/product_card.dart';
import 'package:wei_inventory/providers/inventories_store.dart';
import 'package:wei_inventory/providers/inventory_store.dart';
import 'package:wei_inventory/shared/dialogs/delete_inventory_confirmation.dart';
import 'package:wei_inventory/shared/dialogs/inventory_name.dart';
import 'package:wei_inventory/shared/dialogs/product_name.dart';
import 'package:wei_inventory/shared/screen_title.dart';
import 'package:wei_inventory/shared/widgets/bottom_button.dart';
import 'package:wei_inventory/utils/colors_utils.dart';

class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color buttonColor = randomMaterialColor();

    return Consumer<InventoryStore>(
      builder: (context, inventory, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ScreenTitle(title: inventory.name),
                      Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          ClipOval(
                            child: Material(
                              color: buttonColor, // button color
                              child: InkWell(
                                splashColor: Colors.red,
                                onTap: () async => _updateInventoryName(context, inventory), // inkwell color
                                child: SizedBox(width: 48, height: 48, child: Icon(Icons.edit, color: contrastColor(buttonColor),)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8,),
                          ClipOval(
                            child: Material(
                              color: Colors.red, // button color
                              child: InkWell(
                                splashColor: buttonColor,
                                onTap: () async => _deleteInventory(context, inventory), // inkwell color
                                child: const SizedBox(width: 48, height: 48, child: Icon(Icons.delete, color: Colors.white),)),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2
                      ),
                      itemCount: inventory.products.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: inventory.products[index],
                          child: ProductCard(),
                        );
                      },
                    ),
                  ),
                  BottomButton(
                    defaultColor: buttonColor,
                    onPressed: () async => _addProduct(context, inventory),
                    icon: Icons.add,
                  )
                ],
              )
        );
      }
    );
  }

  Future _updateInventoryName(BuildContext context, InventoryStore inventoryStore) async {
    final String newInventoryName = await inventoryNameDialog(context, defaultValue: inventoryStore.name); 

    if (newInventoryName != null && newInventoryName.isNotEmpty) {
      inventoryStore.updateName(newInventoryName);
    }
  }

  Future _addProduct(BuildContext context, InventoryStore inventoryStore) async {
    final String newProductName = await productNameDialog(context); 

    if (newProductName != null && newProductName.isNotEmpty) {
      inventoryStore.addProduct(newProductName);
    }
  }

  Future _deleteInventory(BuildContext context, InventoryStore inventoryStore) async {
    final bool canDelete = await deleteInventoryConfirmationDialog(context);

    if (canDelete != null && canDelete) {
      Provider.of<InventoriesStore>(context, listen: false).deleteInventory(inventoryStore);
      Navigator.of(context).pop();
    }
  }

}