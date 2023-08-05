import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/fullWidthProductCard.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class myCancellation extends StatelessWidget {
  const myCancellation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<e_commerceProvider>(builder: ((context, value, child) {
      if (value.cancellation.length == 0) {
        return smallText(text: "You do not have canceled any order");
      }
      return Wrap(
        children: List.generate(value.cancellation.length, (index) {
          final product = value.cancellation[index];
          return fullWidthProductCard(
              name: product.name,
              image: product.image,
              brand: product.brand??" ",
              varient: product.varient,
              color: product.color,
              deliveryCharge: product.deliveryCharge,
              perItem: product.perItem,
              quantity: product.quantity);
        }),
      );
    }));
  }
}
