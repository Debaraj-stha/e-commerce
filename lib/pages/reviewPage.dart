import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/pages/singleProductReview.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/fullWidthProductCard.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class reviewPage extends StatefulWidget {
  const reviewPage({super.key});

  @override
  State<reviewPage> createState() => _reviewPageState();
}

class _reviewPageState extends State<reviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
     final provider=Provider.of<e_commerceProvider>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          title: smallText(text: "Review Page"),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: Consumer<e_commerceProvider>(
          builder: (context, value, child) {
           if (value.purchasedProduct.length == 0) {
        return smallText(text: "You do not have purchase any order");
      }
      else if(value.purchasedProduct.isEmpty){
        return CircularProgressIndicator();
      } else {
              return ListView.builder(
                  itemCount: value.purchasedProduct.length,
                  itemBuilder: (context, index) {
                    final product = value.purchasedProduct[index];
                    return InkWell(
                        onTap: () {
                          // provider.ordersProduct(orderAt, orderStatus, image, name, quantity, perItem, productId, orderId, color, shopId, shopName, varient)
                          provider.ordersProduct(DateTime.now().toString(), "pending", product.image, product.name, product.quantity,product.perItem, product.productId,"",product.color,product.shopId!,product.shopName,product.varient);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => singleProductReview(
                                      name: product.name,
                                      id: product.productId)));
                        },
                        child: fullWidthProductCard(
                            name: product.name,
                            image: product.image,
                            brand: product.brand??"",
                            varient: product.varient,
                            color: product.color,
                            deliveryCharge: product.deliveryCharge,
                            perItem: product.perItem,
                            quantity: product.quantity));
                  });
            }
          },
        ));
  }
}

Widget customText(String text,
    {FontWeight weight = FontWeight.normal,
    Color color = const Color.fromARGB(255, 94, 90, 90),
    double padding = 0.0}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: smallText(
      text: text,
      weight: weight,
      color: color,
    ),
  );
}
