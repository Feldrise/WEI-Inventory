import 'package:flutter/material.dart';

Future<bool> deleteInventoryConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Suppression"),
        content: const Text("Voulez vous vraiment supprimer l'inventaire et tous ses produits ?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Annuler'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Oui'),
          ),
        ],
      );
    },
  );
}