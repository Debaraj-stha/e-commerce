import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/pages/chatWithShopPage.dart';
import 'package:e_commerce/pages/questionPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/addToCart.dart';
import 'package:e_commerce/utils/fromSameStore.dart';
import 'package:e_commerce/utils/hilights.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/peopleAlsoViewThis.dart';
import 'package:e_commerce/utils/productQuestion.dart';
import 'package:e_commerce/utils/productReview.dart';
import 'package:e_commerce/utils/recomondetation.dart';
import 'package:e_commerce/utils/searchBar.dart';
import 'package:e_commerce/utils/shopCard.dart';
import 'package:e_commerce/utils/singleReview.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../utils/customRadioButton.dart';

class singleProductPage extends StatefulWidget {
  const singleProductPage({
    super.key,
  });

  @override
  State<singleProductPage> createState() => _singleProductPageState();
}

class _singleProductPageState extends State<singleProductPage> {
  PageController controller = new PageController();

  int currentPage = 0;
  // List<String> images = [
  //   "asset/welcome1.jpg",
  //   "asset/welcome2.jpg",
  //   "asset/welcome3.jpg"
  // ];

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    final product = provider.product;
    return Scaffold(
        appBar: searchBar(),
        body: Consumer<e_commerceProvider>(
          builder: (context, value, child) {
            if (value.product.isEmpty) {
              return CircularProgressIndicator();
            } else {
              debugPrint("p" + product.toString());
              final data = product[0];
              int rating = 0;
              for (int i = 0; i < data.reviewId!.length; i++) {
                rating = rating + data.reviewId![i].rating;
              }
              return Container(
                color: Color.fromARGB(255, 217, 211, 211),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ListView(
                            children: [
                              Container(
                                height: deviceUtils.getDeviceHeight(context) / 3,
                                child: PageView.builder(
                                  onPageChanged: (val) {
                                    currentPage = controller.page!.round();
                                  },
                                  controller: controller,
                                  itemCount: data.images.length,
                                  itemBuilder: (context, index) {
                                    debugPrint(data.images[index]);
                                    return Container(
                                        height: deviceUtils.getDeviceHeight(context) / 3,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(data.images))));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          smallText(
                                            text: "Brand:",
                                            color: Colors.grey,
                                          ),
                                          smallText(
                                            text: data.brand ?? "No brand",
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          mediumText(
                                              text: data.salesPrice.toString(),
                                              color: constraunts.primary),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          smallText(
                                            text: data.price.toString(),
                                            decoration: TextDecoration.lineThrough,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: constraunts.primary,
                                          ),
                                          data.reviewId!.isNotEmpty
                                              ? smallText(
                                                  text: (rating / data.reviewId!.length)
                                                      .ceil()
                                                      .toString())
                                              : Container(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          data.sold != null
                                              ? smallText(text: "sold:${data.sold}")
                                              : Container()
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            smallText(text: "Delivery charge:"),
                                            smallText(
                                              text: data.deliveryCharge.toString(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data.color!.isNotEmpty
                                        ? smallText(text: "Color Family:")
                                        : Container(),
                                    data.color!.length != 0
                                        ? Consumer<e_commerceProvider>(
                                            builder: ((context, value, child) {
                                            return Row(
                                                children: List.generate(
                                                    data.color!.length,
                                                    (index) => CustomRadioButton(
                                                        index,
                                                        data.color![index],
                                                        context,
                                                        true)));
                                          }))
                                        : Container(),
                                    data.variant!.isNotEmpty
                                        ? smallText(text: "Size/Varient:")
                                        : Container(),
                                    data.variant!.isNotEmpty
                                        ? Consumer<e_commerceProvider>(
                                            builder: ((context, value, child) {
                                            return Row(
                                                children: List.generate(
                                                    data.variant!.length,
                                                    (index) => CustomRadioButton(
                                                        index,
                                                        data.variant![index],
                                                        context,
                                                        false)));
                                          }))
                                        : Container(),
                                    smallText(text: "Service:"),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomRow("100% authentic"),
                                        CustomRow("15 dayss of easy return"),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                              const smallText(
                                                  text: "Warenty not awailable"),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    smallText(text: "Ratings and Review"),
                                    InkWell(
                                      onTap: () {
                                        provider.toggleReview();
                                      },
                                      child: smallText(
                                        text:
                                            "View All (${data.reviewId!.length.toString()})",
                                        color: constraunts.primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              productReview(review: data.reviewId),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    smallText(text: "Question about this product"),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>questionPage( question: data.questionId, shop: data.shopId,productId:data.id)));
                                        provider.toggleQuestion();
                                      },
                                      child: smallText(
                                        text:
                                            "View All (${data.questionId!.length.toString()})",
                                        color: constraunts.primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              productQuestion(
                                  question: data.questionId, shop: data.shopId),
                              Divider(),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.white,
                                  child: InkWell(
                                      child: Center(
                                    child: smallText(text: "Ask Question"),
                                  ))),
                              shopCardd(name: data.shopId.name),
                              Divider(),
                              Container(child: smallText(text: "Recomonded By Seller")),
                              Divider(),
                              Recommendation(recommended: data.recommended),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: smallText(
                                  text: "Hilights",
                                ),
                              ),
                              Divider(),
                              hilights(hilight: data.hilights),
                              Divider(),
                              smallText(
                                text: "Description",
                              ),
                              Divider(),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(8),
                                child: smallText(text: data.description),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: smallText(
                                  text: "People also view this item",
                                ),
                              ),
                              Divider(),
                              peopleAlsoViewThis(),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: smallText(text: "From the same Store"),
                              ),
                              Divider(),
                              fromSameStore(fromSameStoreProduct: data.fromSameStore),
                              Divider(),
                             
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.shop_two,
                                        color: constraunts.primary),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>chatWithShopPage(shopName: data.shopId.name, shopId: data.shopId.id)));
                                      },
                                      icon: Icon(Icons.chat_bubble,
                                          color: constraunts.primary)),
                                  TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: constraunts.primary)))),
                                    child: smallText(
                                        text: "Buy Now", color: constraunts.primary),
                                    onPressed: () {},
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: constraunts.primary)))),
                                    child: smallText(
                                        text: "Add to Cart",
                                        color: constraunts.primary),
                                    onPressed: () {
                                      showModel(
                                          context,
                                          data.images,
                                          data.salesPrice.toString(),
                                          data.price.toString(),
                                          data.color,
                                          data.variant,
                                          data.id,
                                          data.shopId.id,
                                          data.name,data.brand,data.variant,data.shopId.name);
                                    },
                                  )
                                ],
                              ),
                            )
                  ],
                ),
              );
            }
          },
        ));
  }
}

Widget CustomRow(String text) {
  return Row(children: [
    Checkbox(value: true, onChanged: (val) {}),
    smallText(text: text)
  ]);
}
