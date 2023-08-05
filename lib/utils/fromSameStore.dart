import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:e_commerce/utils/recomondetation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class fromSameStore extends StatelessWidget {
  const fromSameStore({super.key,required this.fromSameStoreProduct});
final List fromSameStoreProduct;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(8),
    height: deviceUtils.getDeviceHeight(context)/2,
      color: Colors.white,
      child: GridView.builder(
        
          itemCount: fromSameStoreProduct.length,
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: deviceUtils.getDeviceHeight(context) / 3.8,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return productCard(
              id:fromSameStoreProduct[index].id,
              image: fromSameStoreProduct[index].images,
              text:fromSameStoreProduct[index].name,
              price: fromSameStoreProduct[index].salesPrice.toString(),
              rating: "4.5/5",
              oldPrice:fromSameStoreProduct[index].price.toString(),
              sold: fromSameStoreProduct[index].sold.toString(),
            );
          }));
  }
}