import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory/providers/inventory_store.dart';
import 'package:wei_inventory/providers/procut_store.dart';
import 'package:wei_inventory/shared/dialogs/delete_product_confirmation.dart';
import 'package:wei_inventory/shared/dialogs/product_name.dart';
import 'package:wei_inventory/utils/colors_utils.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color productColor = randomMaterialColor(); 
    return Consumer<ProductStore>(
      builder: (context, product, child) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(
            //     builder: (context) => ChangeNotifierProvider.value(
            //       value: inventory,
            //       child: InventoryPage(),
            //     )
            //   )
            // );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                top: BorderSide(
                  color: productColor,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: Theme.of(context).textTheme.subtitle1,),
                const SizedBox(height: 16),
                Expanded(
                  child: Text("Quantité : ${product.quantity}", style: Theme.of(context).textTheme.headline2,),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColor, // button color
                        child: InkWell(
                          splashColor: productColor, // inkwell color
                          onTap: () async => _removeOneProduct(context, product),
                          child: const SizedBox(width: 48, height: 48, child: Icon(Icons.remove)),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColor, // button color
                        child: InkWell(
                          splashColor: productColor, // inkwell color
                          onTap: () async => _addOneProduct(context, product),
                          child: const SizedBox(width: 48, height: 48, child: Icon(Icons.add)),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColor, // button color
                        child: InkWell(
                          splashColor: productColor, // inkwell color
                          onTap: () async => _updateProductName(context, product),
                          child: const SizedBox(width: 48, height: 48, child: Icon(Icons.edit)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future _updateProductName(BuildContext context, ProductStore productStore) async {
    final String newProductName = await productNameDialog(context, defaultValue: productStore.name); 

    if (newProductName != null && newProductName.isNotEmpty) {
      productStore.updateName(newProductName);
      await Provider.of<InventoryStore>(context, listen: false).saveInventory();
    }
  }

  Future _addOneProduct(BuildContext context, ProductStore productStore) async {
    productStore.addOne();
    await Provider.of<InventoryStore>(context, listen: false).saveInventory();
  }

  Future _removeOneProduct(BuildContext context, ProductStore productStore) async {
    if (productStore.quantity == 1) {
      final bool delete = await deleteProductConfirmationDialog(context);

      if (delete != null && delete) {
        await Provider.of<InventoryStore>(context, listen: false).deleteProduct(productStore);
      }

      return;
    }

    productStore.removeOne();
    await Provider.of<InventoryStore>(context, listen: false).saveInventory();
  }
}