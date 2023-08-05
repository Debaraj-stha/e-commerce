import 'dart:convert';

import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages/singleCardPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class productCard extends StatefulWidget {
  const productCard(
      {super.key,
      required this.image,
      required this.text,
      required this.price,
      this.rating,
      required this.id,
      this.category,
      this.subCategory,
      this.oldPrice,
      this.tag,
      this.sold});
  final String image;
  final String id;
  final String text;
  final String price;
  final String? category;
  final String? subCategory;
  final String?rating;
  final String? oldPrice;
final List? tag;
  final String? sold;
  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<e_commerceProvider>(context, listen: false)
            .fetchProduct(widget.id);
            Map<String,dynamic> item={"category":widget.category??"","subCategory":widget.subCategory??"","tag":widget.tag};
            int id=DateTime.now().millisecond;
            Provider.of<e_commerceProvider>(context, listen: false).storeUserActivity(userActivity(id:id, item:jsonEncode(item) ));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => singleProductPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        height: deviceUtils.getDeviceHeight(context) / 4,
        width: deviceUtils.getDeviceWidth(context) / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            Container(
              height: deviceUtils.getDeviceHeight(context) / 7,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.contain),
              ),
            ),
            smallText(text: widget.text),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: constraunts.primary,
                    ),
                    widget.rating!=null?
                    smallText(
                      text: widget.rating!,
                      color: constraunts.primary,
                    ):Container(),
                    smallText(text: "(9)")
                  ],
                ),
                smallText(
                    text: widget.sold == null ? "" : "sold ${widget.sold}")
              ],
            ),
            Row(
              children: [
                smallText(text: widget.price, color: constraunts.primary),
                SizedBox(
                  width: 5,
                ),
                smallText(
                  text: widget.oldPrice ?? "",
                  decoration: TextDecoration.lineThrough,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
