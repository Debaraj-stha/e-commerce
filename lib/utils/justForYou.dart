import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/pages/singleCardPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class justForYou extends StatefulWidget {
  justForYou({super.key});

  @override
  State<justForYou> createState() => _justForYouState();
}

class _justForYouState extends State<justForYou> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<e_commerceProvider>(context,listen:false).getForYouProduct();
   return Consumer<e_commerceProvider>(builder: ((context, value, child) {
  
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
  child: GridView.builder(
    itemCount: value.forYouProduct.length,
    shrinkWrap: true, // Set shrinkWrap to true
    physics: NeverScrollableScrollPhysics(), // Prevent scrolling within GridView
    padding: EdgeInsets.all(8),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: deviceUtils.getDeviceHeight(context) / 3.8,
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    itemBuilder: (context, index) {
      final product=value.forYouProduct[index];
      return productCard(
        image: product.image,
        text: product.name,
        price: product.salesPrice.toString(),
        oldPrice: product.price.toString(),
        sold: product.sold.toString(),
        id: product.id,
      );
    },
  ),


    );
     
   }),);
   
  }
}
