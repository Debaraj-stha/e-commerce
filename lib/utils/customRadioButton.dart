import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

Widget CustomRadioButton(
    int index, String text, BuildContext context, bool isColor) {
  return Consumer<e_commerceProvider>(builder: ((context, value, child) {
    if (isColor) {
     return  TextButton(
        onPressed: () {
          Provider.of<e_commerceProvider>(context, listen: false)
              .handleCustomRadioButton(index, true);
        },
        style: ButtonStyle(),
        child: smallText(
          text: text,
          color: value.selectedItemColor != index ? Colors.black : constraunts.primary,
        ),
      );
    } else {
      return TextButton(
        onPressed: () {
          Provider.of<e_commerceProvider>(context, listen: false)
              .handleCustomRadioButton(index, false);
        },
        style: ButtonStyle(),
        child: smallText(
          text: text,
          color: value.selectedSize!=index ? Colors.black : constraunts.primary,
        ),
      );
    }
  }));
}
