import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';
import '../utils/fullWidthProductCard.dart';
import '../utils/smallText.dart';

class receivePage extends StatefulWidget {
  const receivePage({super.key});

  @override
  State<receivePage> createState() => _receivePageState();
}

class _receivePageState extends State<receivePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2,
        title: smallText(text: "To Receive"),
      ),
      body: Consumer<e_commerceProvider>(builder: ((context, value, child) {
      if (value.toReceiveProduct.length == 0) {
        return smallText(text: "You do not have purchase any order");
      }
      else if(value.toReceiveProduct.isEmpty){
        return CircularProgressIndicator();
      }
      return Wrap(
        children: List.generate(value.toReceiveProduct.length, (index) {
          final product = value.toReceiveProduct[index];
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
    }))
    );
  }
}