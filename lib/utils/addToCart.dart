import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/customRadioButton.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/quantityHandle.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showModel(
    BuildContext context,
    String image,
    String salesPrice,
    String price,
    List<dynamic>? color,
    List<dynamic>? varient,
    id,
    String shopId,
    String name,
     brand,
     List?variant,
     String shopName
    ) {
  final provider = Provider.of<e_commerceProvider>(context, listen: false);
  final selectedItemColor = provider.selectedItemColor;
  final selectedItemSize = provider.selectedSize;
   final quantity = provider.quantity;
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 175, 169, 168),
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText(text: salesPrice, color: constraunts.primary),
                      smallText(
                        text: price,
                        decoration: TextDecoration.lineThrough,
                      ),
                      Consumer<e_commerceProvider>(
                          builder: (context, value, child) {
                        return Row(
                          children: [
                            smallText(text: "Size:"),
                            smallText(text: color![value.selectedItemColor]??""),
                            smallText(text: ",${varient![value.selectedSize]}")
                          ],
                        );
                      })
                    ],
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close))
                ],
              ),
              Divider(
                thickness: 1,
              ),
              smallText(text: "Color Family:"),
              Consumer<e_commerceProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: List.generate(
                        color!.length,
                        (index) => CustomRadioButton(
                            index, color[index], context, true)),
                  );
                },
              ),
              smallText(text: "Size:"),
              Consumer<e_commerceProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: List.generate(
                        varient!.length,
                        (index) => CustomRadioButton(
                            index, varient[index], context, false)),
                  );
                },
              ),
              Divider(
                thickness: 1,
              ),
              quantityHandle(),
              Divider(
                thickness: 1,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    provider.initialize();
                    provider.addToCart(name, image, shopId, id, int.parse(salesPrice), 20, color![selectedItemColor], varient![selectedItemSize],brand:brand, shopName);
                    // provider.addToCart(name, image, shopId, id, int.parse(salesPrice), 77, color![selectedItemColor],variant![selectedItemSize], brand??"",shopName);
                  },
                  child: smallText(
                    text: "Add to cart",
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: constraunts.primary),
                ),
              )
            ],
          ),
        );
      });
}
