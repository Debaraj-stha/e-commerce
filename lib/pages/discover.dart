import 'package:e_commerce/model/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';
import '../utils/productCard.dart';

class discover extends StatefulWidget {
  const discover({super.key});

  @override
  State<discover> createState() => _discoverState();
}

class _discoverState extends State<discover> {
  @override
  void initState() {
    // TODO: implement initState
      final provider = Provider.of<e_commerceProvider>(context, listen: false).getDiscoverProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    

    return Consumer<e_commerceProvider>(builder: ((context, value, child) {
      return Container(
        child: GridView.builder(
          itemCount: value.discoveredProduct.length,
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: deviceUtils.getDeviceHeight(context) / 3.8,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
           
          itemBuilder: (context, index) {
            final product = value.discoveredProduct[index];
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 5, offset: Offset(0, 3), color: Colors.grey)
              ]),
              child: productCard(
                sold: product.sold.toString(),
                image: product.image,
                text: product.name,
                price: product.price.toString(),
                id: product.id,
                category: product.category,
                oldPrice: product.salesPrice.toString(),
                subCategory: product.subCategory,
               
              ),
            );
          },
     
        ),
      );
    }));
  }
}