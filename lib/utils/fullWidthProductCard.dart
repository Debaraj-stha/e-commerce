import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class fullWidthProductCard extends StatefulWidget {
  const fullWidthProductCard({super.key,required this.name,required this.image,required this.brand,required this.varient,required this.color,required this.deliveryCharge,required this.perItem,required this.quantity});
final String name;
final String image;
final String brand;
final String varient;
final int deliveryCharge;
final int quantity;
final String color;
final int perItem;
  @override
  State<fullWidthProductCard> createState() => _fullWidthProductCardState();
}

class _fullWidthProductCardState extends State<fullWidthProductCard> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallText(
                              text: "item name",
                              weight: FontWeight.w700,
                              color: Colors.black),
                          Row(
                            children: [
                              smallText(text: "Brand:${widget.brand}"),
                              smallText(text: "Color:red")
                            ],
                          ),
                          Row(
                            children: [
                              smallText(text: "Size:${widget.varient},"),
                            ],
                          ),
                          Row(
                            children: [
                              smallText(text: "Delivery charge:"),
                              smallText(
                                  weight: FontWeight.w700,
                                  text: "${widget.deliveryCharge}")
                            ],
                          ),
                          Row(
                            children: [
                              smallText(
                                  weight: FontWeight.w700,
                                  text: "RS:${widget.perItem}",
                                  color: constraunts.primary),
                              Spacer(),
                              smallText(
                                  text: "Quantity:${widget.quantity}",
                                  weight: FontWeight.w600)
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    )
                  ]);
  }
}