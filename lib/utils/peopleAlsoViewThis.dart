import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class peopleAlsoViewThis extends StatelessWidget {
  const peopleAlsoViewThis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
    height: deviceUtils.getDeviceHeight(context)/2,
      color: Colors.white,
      child: GridView.builder(
        
          itemCount: 10,
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: deviceUtils.getDeviceHeight(context) / 3.8,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return productCard(
              id:"3939399",
              image: "asset/welcome3.jpg",
              text: "category product item category item page",
              price: "Rs 750",
              rating: "4.5/5",
              oldPrice: "800",
              sold: "120",
            );
          }),
    );
  }
}
