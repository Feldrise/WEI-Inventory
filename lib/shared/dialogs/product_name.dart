import 'package:flutter/material.dart';
import 'package:wei_inventory/utils/colors_utils.dart';

Future<String> productNameDialog(BuildContext context, {String defaultValue = ""}) {
  String _productName = '';

  return showDialog<String>(
    context: context,
    barrierDismissible: true, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Entez le nom du produit"),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                controller: TextEditingController()..text = defaultValue ?? '',
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: randomMaterialColor(),
                      width: 3
                    )
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: randomMaterialColor(),
                      width: 3
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: randomMaterialColor(),
                      width: 3
                    )
                  ),
                  labelText: "Nom du produit", 
                  hintText: "Nom", 
                ),
                onChanged: (value) {
                  _productName = value;
                },
              )
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop("");
            },
            child: const Text('Annuler'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(_productName);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}