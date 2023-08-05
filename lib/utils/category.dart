import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/categoryItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class category extends StatelessWidget {
  const category({super.key});

  @override
  Widget build(BuildContext context) {
    final categories=Provider.of<e_commerceProvider>(context,listen:false).productCategories;
    return Consumer<e_commerceProvider>(builder: ((context, value, child) {
      if (value.productCategories == null) {
        return CircularProgressIndicator();
      } else {
      return  Container(
          height: deviceUtils.getDeviceHeight(context) / 4,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
              // categories.length>5?5:
              categories.length ,
              itemBuilder: ((context, index) {
                return categoryItem(
                  category:categories[index].category,
                    image: categories[index].image, text: categories[index].name);
              })),
        );
      }
    }));
  }
}
