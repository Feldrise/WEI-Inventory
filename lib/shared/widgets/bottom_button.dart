import 'package:flutter/material.dart';
import 'package:wei_inventory/utils/colors_utils.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({Key key, this.defaultColor, @required this.onPressed, @required this.icon}) : super(key: key);

  final Color defaultColor;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = randomMaterialColor();

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(right: 32),
        padding: const EdgeInsets.only(top: 8),
        color: defaultColor ?? buttonColor,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: defaultColor ?? buttonColor,
          shape: const RoundedRectangleBorder(),
          child: Icon(icon, color: contrastColor(defaultColor ?? buttonColor),),
        ),
      ),
    );
  }

}