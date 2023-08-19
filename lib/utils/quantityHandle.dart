import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class quantityHandle extends StatefulWidget {
  const quantityHandle({super.key,required this.productId});
 final String productId;
  @override
  State<quantityHandle> createState() => _quantityHandleState();
}

class _quantityHandleState extends State<quantityHandle> {
 
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    final selectedItemColor = provider.selectedItemColor;
    final selectedItemSize = provider.selectedSize;
    String p =widget.productId;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        smallText(text: "Quantity:"),
        Consumer<e_commerceProvider>(builder: ((context, value, child) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (provider.isDisableButton[0]) {
                      provider.disableButton(value.quantity[p]);
                      provider.handleQuantityCount(
                          false, value.quantity[p],p, context);
                    } else {
                      null;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: smallText(
                      text: "-",
                      color: !value.isDisableButton[0]
                          ? Color.fromARGB(255, 163, 159, 159)
                          : Color.fromARGB(255, 211, 200, 200),
                    ),
                    decoration: BoxDecoration(
                        color: !value.isDisableButton[0]
                            ? Color.fromARGB(255, 222, 217, 217)
                            : Colors.black,
                        border: Border(
                            right: BorderSide(color: Colors.black, width: 1))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: smallText(
                    text: value.quantity.toString(),
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.black, width: 1))),
                ),
                InkWell(
                  onTap: () {
                    if (provider.isDisableButton[1]) {
                      provider.disableButton(value.quantity[p]);
                      provider.handleQuantityCount(
                          true, value.quantity[p],p, context);
                    } else {
                      null;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    color: !value.isDisableButton[1]
                        ? Color.fromARGB(255, 222, 217, 217)
                        : Colors.black,
                    child: smallText(
                      text: "+",
                      color: !value.isDisableButton[0]
                          ? Color.fromARGB(255, 163, 159, 159)
                          : Color.fromARGB(255, 211, 200, 200),
                    ),
                  ),
                )
              ],
            ),
          );
        })),
      ],
    );
  }
}
