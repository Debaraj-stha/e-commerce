import 'package:e_commerce/pages/homepage.dart';
import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/bigText.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  List<Map<String, dynamic>> welcomeData = [
    {
      "mainText": "welcome to our e-commerce site",
      "text": "shop from millions of products,100 of categories and top brands",
      "image": "asset/welcome1.jpg",
      "color": Colors.orange
    },
    {
      "mainText": "search,discover and enjoy",
      "text": "start your shopping through personalize channel and shops",
      "image": "asset/welcome2.jpg",
      "color": Colors.lightBlue
    },
    {
      "mainText": "100% buyer protection",
      "text": "easy returns and refunds",
      "image": "asset/welcome3.jpg",
      "color": Colors.indigo
    },
    {
      "mainText": "pay as you wish",
      "text":
          "variety of payment options including cash on delivery,bank card and emi",
      "image": "asset/welcome4.jpg",
      "color": Colors.green
    }
  ];
  PageController controller = PageController(keepPage: true);
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: deviceUtils.getDeviceHeight(context) / 1,
          child: PageView.builder(
              onPageChanged: (int v) {
                setState(() {
                  currentPage = v;
                });
                controller.nextPage(
                    duration: Duration(seconds: 1), curve: Curves.linear);
              },
              itemCount: welcomeData.length,
              controller: controller,
              itemBuilder: (context, index) {
                return Container(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.pink,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 15),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                bigText(
                                    text: welcomeData[index]["mainText"],
                                    color: Colors.white),
                                mediumText(
                                    text: welcomeData[index]["text"],
                                    color: Colors.white),
                              ],
                            ),
                            height: deviceUtils.getDeviceHeight(context),
                            color: welcomeData[index]["color"]),
                      ),
                      Positioned(
                          bottom: 100,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: deviceUtils.getDeviceHeight(context) / 2,
                              width: MediaQuery.of(context).size.width,
                              child: Image(
                                image: AssetImage(welcomeData[index]["image"]),
                                fit: BoxFit.cover,
                              )))
                    ],
                  ),
                );
              }),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(221, 79, 71, 71),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: welcomeData.length,
                  effect: const WormEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    type: WormType.thinUnderground,
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      await SessionManager().set("isClick", true);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}


