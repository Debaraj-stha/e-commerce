import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages/categoryPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/category.dart';
import 'package:e_commerce/utils/justForYou.dart';
import 'package:e_commerce/utils/productSuggestion.dart';
import 'package:e_commerce/utils/searchBar.dart';
// import 'package:e_commerce/utils/searchBar.dart';
import 'package:e_commerce/utils/slideShowPage.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../utils/lowestPriceProduct.dart';
import 'dart:async';

class homePageTab extends StatefulWidget {
  const homePageTab({super.key});

  @override
  State<homePageTab> createState() => _homePageTabState();
}

class _homePageTabState extends State<homePageTab> {
  @override

  void initState() {
    // TODO: implement initState
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    provider.fetchProductCategories();
    // provider.getuserActivity();
    //  Provider.of<e_commerceProvider>(context, listen: false).getRecomondation();
    //  setDelayTime();
    super.initState();
  }

  setDelayTime() {
    Future.delayed(Duration(seconds: 3), () {
      Provider.of<e_commerceProvider>(context, listen: false)
          .getRecomondation();
    });
    debugPrint("called the metho");
  }

  @override
  constraunts? myConstraints;

  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void search() {}
  @override
  Widget build(BuildContext context) {
    // Provider.of<e_commerceProvider>(context, listen: false).getLocation();
    return Scaffold(
        appBar: searchBar(
          isHome: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(6),
          children: [
            slideShowPage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                smallText(text: "Categories",weight: FontWeight.w700,),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => categoryPage()));
                  },
                  child: smallText(
                    text: "See More",
                    color: constraunts.primary,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: constraunts.primary,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            category(),
            smallText(
              text: "Recomondation for you",
              weight: FontWeight.w700,
            ),
            productSuggestion(),
            smallText(
              text: "Just For You",
              weight: FontWeight.w700,
            ),
            justForYou(),
            smallText(text: "At lowest price", weight: FontWeight.w700),
            lowestPriceProduct()
          ],
        ));
  }
}
