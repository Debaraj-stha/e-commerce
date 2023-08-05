import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class lowestPriceProduct extends StatefulWidget {
  const lowestPriceProduct({super.key});

  @override
  State<lowestPriceProduct> createState() => _lowestPriceProductState();
}

class _lowestPriceProductState extends State<lowestPriceProduct> {
  @override
  void initState() {
    Provider.of<e_commerceProvider>(context, listen: false).filterFreeDelivery(0, "", "all");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);

    return Consumer<e_commerceProvider>(builder: ((context, value, child) {
      return Container(
        child: GridView.builder(
          itemCount: value.lowPriceProduct.length,
          shrinkWrap: true, // Set shrinkWrap to true
          physics:
              NeverScrollableScrollPhysics(), // Prevent scrolling within GridView
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: deviceUtils.getDeviceHeight(context) / 3.8,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
           
          itemBuilder: (context, index) {
            final product = value.lowPriceProduct[index];
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 5, offset: Offset(0, 3), color: Colors.grey)
              ]),
              child: productCard(
                image: product.image,
                text: product.name,
                price: product.price.toString(),
                id: product.id,
              ),
            );
          },
     
        ),
      );
    }));
    //     return Container(
    //       constraints: BoxConstraints(
    //           maxHeight: 400), // Set a maximum height for the widget
    //       child: CustomScrollView(
    //         slivers: [
    //           SliverGrid(
    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               mainAxisSpacing: 6,
    //               mainAxisExtent: 200,
    //               crossAxisSpacing: 6,
    //             ),
    //             delegate: SliverChildBuilderDelegate(
    //               (context, index) {
    //                 final product = value.lowPriceProduct[index];

    //                 return Container(
    //                   decoration: BoxDecoration(
    //                     boxShadow: [
    //                       BoxShadow(blurRadius: 5,offset: Offset(0, 3),color:Colors.grey)
    //                     ]
    //                   ),
    //                   child: productCard(
    //                     image: product.image,
    //                     text: product.name,
    //                     price: product.price.toString(),
    //                     id: product.id,
    //                   ),
    //                 );
    //               },
    //               childCount: value.lowPriceProduct.length,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }),
    // );
  }
}
