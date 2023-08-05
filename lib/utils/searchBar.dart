import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages/categoryItemPage.dart';
import 'package:e_commerce/pages/categoryPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/customBadge.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class searchBar extends StatelessWidget implements PreferredSizeWidget {
  searchBar({super.key, this.isHome = false, this.isShownIcon = false});

  final bool isHome;
  final bool isShownIcon;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<e_commerceProvider>(context, listen: false);
        final controller=provider.controller;
         provider.initialize();

    provider.loadCartData();
    return AppBar(
      leading: isHome
          ? null
          : BackButton(
              color: Colors.black,
            ),
      backgroundColor: Colors.white,
      title: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: TextFormField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: controller,
          decoration: InputDecoration(
            prefixIconColor: Colors.black,
            suffix: InkWell(
              onTap: (){
                int id=DateTime.now().microsecond;
                provider.storeUserActivity(userActivity(id: id, item: controller.text));
                provider.searchProduct();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>categoryItemPage(category: provider.controller.text)));
              },
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            hintText: "Search here...",
            border: InputBorder.none,
          ),
        ),
      ),
      actions: [
        isShownIcon
            ? Center(
              child: Stack(
                children: [
                  const Icon(Icons.shopping_cart,color: Colors.black),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Consumer<e_commerceProvider>(builder: (context,value,child){
                      return value.getCartItemLength()>0? customBadge(value.getCartItemLength().toString()):Container();
                    },)
                  ),
                ],
              ),
            )
            : Container(),
        isShownIcon
            ? PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  provider.handlePopUpMenu(value, context);
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: smallText(
                          text: "Home",
                          color: Colors.black,
                        ),
                        value: "home",
                      ),
                      PopupMenuItem(
                        child: smallText(
                          text: "Message",
                          color: Colors.black,
                        ),
                        value: "message",
                      ),
                      PopupMenuItem(
                        child: smallText(
                          text: "My Account",
                          color: Colors.black,
                        ),
                        value: "myAccount",
                      ),
                    ])
            : Container()
      ],
    );
  }
}
