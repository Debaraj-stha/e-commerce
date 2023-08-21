import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages/paymentPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class orderPerocess extends StatefulWidget {
  const orderPerocess({super.key});

  @override
  State<orderPerocess> createState() => _orderPerocessState();
}

class _orderPerocessState extends State<orderPerocess> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: const smallText(text: "Checkout(1)"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Color.fromARGB(255, 205, 202, 202),
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText("Deliver to:John",
                                weight: FontWeight.w700,
                                padding: 8,
                                color: Colors.black),
                            InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Consumer<e_commerceProvider>(
                                      builder: ((context, value, child) {
                                    return smallText(
                                        text: value.myLocation.toString());
                                  })),
                               
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                            customText("9819336010",
                                padding: 8, color: Colors.black),
                            Divider(
                              thickness: 2,
                            ),
                            customText("xyz@gmail.com",
                                padding: 8, color: Colors.black),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                      Consumer<e_commerceProvider>(
                    builder: (context, value, child) {
                      if (value.cart.isEmpty) {
                        return Center(
                          child: smallText(text: "you do not have any cart items yet"),
                        );
                      } else if (value.cart.length == 0) {
                        return CircularProgressIndicator();
                      } else {
                        final checkedProduct = provider.getCheckedCartItem();
                        return Column(
                          children: checkedProduct.map((product) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smallText(
                                   text: product.items.first.shopName,
                               
                                  ),
                                  Divider(thickness: 2),
                                  ...product.items.map((item) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(item.image),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                smallText(text:item.name, weight: FontWeight.w700, color: Colors.black),
                                                Row(
                                                  children: [
                                                    smallText(text:"Brand:no brand"),
                                                    smallText(text:"Color:red"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    smallText(text:"Size:L,"),
                                                    smallText(text:"instock:6"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    smallText(text:"Delivery charge:"),
                                                    smallText(text:"${item.deliveryCharge}", weight: FontWeight.w700),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    smallText(text:"RS:${item.perItem}", weight: FontWeight.w700, color: constraunts.primary),
                                                    Spacer(),
                                                    smallText(text:"Quantity:${item.quantity}", weight: FontWeight.w600),
                                                  ],
                                                ),
                                                Divider(thickness: 2),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  smallText(text:"Received until:23 july", weight: FontWeight.w700, ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText("Payment summary",
                                weight: FontWeight.w700,
                                padding: 8,
                                color: Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText("Items cost:",
                                    padding: 8, color: Colors.black),
                                customText("3229",
                                    padding: 8, color: Colors.black)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText("Deliver charge:",
                                    padding: 8, color: Colors.black),
                                customText("100",
                                    padding: 8, color: Colors.black)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText("Total cost:",
                                    padding: 8, color: Colors.black),
                                customText(12920.toString(),
                                    padding: 8, color: Colors.black)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 213, 208, 208),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallText(
                  text: "Total:RS 10000",
                  weight: FontWeight.w700,
                ),
                TextButton(
                  onPressed: () {
                    // provider.deleteCartItem(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => paymentPage()));
                  },
                  child: smallText(
                    text: "Order Now",
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(primary: constraunts.primary),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget customText(String text,
    {FontWeight weight = FontWeight.normal,
    Color color = const Color.fromARGB(255, 173, 168, 168),
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

Widget productList() {
  return Container(
    child: Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/welcome1.jpg"), fit: BoxFit.cover)),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  "product name Invalid argument(s): No host specified in URI file:///asset/welcome3.jpg",
                  color: Colors.black),
              Row(
                children: [customText("Brand:None,"), customText("Color:red")],
              ),
              Row(
                children: [customText("Size:L,"), customText("instock:6")],
              ),
              Row(
                children: [customText("Delivery charge:"), customText("83838")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Rs 245", color: constraunts.primary),
                  customText("12")
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
