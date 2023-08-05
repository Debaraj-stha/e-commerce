import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';
import '../utils/fullWidthProductCard.dart';

class returnPage extends StatefulWidget {
  const returnPage({super.key});

  @override
  State<returnPage> createState() => _returnPageState();
}

class _returnPageState extends State<returnPage> {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
         appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2,
        title: smallText(text: "Return Product"),
      ),
        body:Consumer<e_commerceProvider>(builder: ((context, value, child) {
      if (value.purchasedProduct.length == 0) {
        return smallText(text: "You do not have purchased any product");
      }
      else if(value.purchasedProduct.isEmpty){
        return CircularProgressIndicator();
      }
      return Wrap(
        children: List.generate(value.purchasedProduct.length, (index) {
          final product = value.purchasedProduct[index];
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