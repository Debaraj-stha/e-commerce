import 'package:e_commerce/pages/accountPage.dart';
import 'package:e_commerce/pages/cart.dart';
import 'package:e_commerce/pages/discover.dart';
import 'package:e_commerce/pages/homepageTab.dart';
import 'package:e_commerce/pages/message.dart';
import 'package:e_commerce/pages/welcomePage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/slideShowPage.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'package:provider/provider.dart';

import '../utils/customBadge.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int currenttab = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    // getSession();
    super.initState();
  }

  getSession() async {
    dynamic token = await SessionManager().get("isClick");
    if (token == null || token == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => welcomePage()));
    }
  }

  List<Widget> tabData = [
    homePageTab(),
    myMessagePage(),
    discover(),
    cart(),
    accountPage()
  ];
  int _cartItemsCount = 6;
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<e_commerceProvider>(context,listen: false);
    provider.getCartItemLength();
    // provider.getLocation();
    // provider.getPurchaseList();
    return Scaffold(
      body: tabData[currenttab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currenttab,
          onTap: (value) {
            setState(() {
              currenttab = value;
            });
          },
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black26,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: Colors.black26,
                ),
                label: "Message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.inventory,
                  color: Colors.black26,
                ),
                label: "Discover"),
            BottomNavigationBarItem(
              icon: Stack(
              children: [
                const Icon(Icons.shopping_cart,color: Colors.black26),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Consumer<e_commerceProvider>(builder: (context,value,child){
                    return value.getCartItemLength()>0? customBadge(value.getCartItemLength().toString()):Container();
                  },)
                ),
              ],
            ),
            label: 'Cart',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black26,
                ),
                label: "Account"),
          ]),
    );
  }
}
