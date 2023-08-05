import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/message.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class myAppBar extends StatelessWidget implements PreferredSizeWidget {
  const myAppBar({super.key, required this.cartItemLength});
  final int cartItemLength;
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<e_commerceProvider>(context,listen: false);
    return AppBar(
      backgroundColor: Colors.white,
      leading: BackButton(color: Colors.black),
      title: smallText(text: "My Cart(${provider.getCartItemLength()})"),
      actions: [
        TextButton(
          child: smallText(
            text: "Delete",
          ),
          onPressed: () {
            provider.deleteCartItem(context);
            message("clicked", false);
          },
        )
      ],
    );
  }
}
