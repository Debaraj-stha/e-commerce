import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/pages/singleCardPage.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class productSuggestion extends StatefulWidget {
  productSuggestion({super.key});

  @override
  State<productSuggestion> createState() => _productSuggestionState();
}

class _productSuggestionState extends State<productSuggestion> {
  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    final provider=Provider.of<e_commerceProvider>(context, listen: false);
      //  provider.fetchProductCategories();
         provider.getuserActivity();
           Provider.of<e_commerceProvider>(context, listen: false).getRecomondation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<e_commerceProvider>(context, listen: false);
provider.getRecomondation();
    return Consumer<e_commerceProvider>(builder: ((context, value, child) {
      // if(value.recomondedProduct.isEmpty){
      //   return Center(child: smallText(text: "No suggestion"),);
      // }
      // else if(value.recomondedProduct.length==0){
      //   return CircularProgressIndicator();
      // }
      return Container(
        child: GridView.builder(
          itemCount: value.recomondedProduct.length,
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
            final product = value.recomondedProduct[index];
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
  }
}
