import 'dart:async';
import 'package:e_commerce/utils/bigText.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class slideShowPage extends StatefulWidget {
  const slideShowPage({Key? key}) : super(key: key);

  @override
  State<slideShowPage> createState() => _slideShowPageState();
}

class _slideShowPageState extends State<slideShowPage> {
  List<String> images = [
    "asset/download.jpg",
    "asset/images1.jpg",
    "asset/images3.jpg",
    "asset/images4.jpg",
    "asset/images2.jpg",
    "asset/images5.jpg",
    
  ];
  PageController controller = PageController(initialPage: 0);
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      controller.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 200,
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (val) {
              setState(() {
                currentPage = val;
              });
            },
            itemCount: images.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(images[index]),fit: BoxFit.cover)
                ),
                
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SmoothPageIndicator(
                controller: controller,
                count: images.length,
                effect:ColorTransitionEffect(activeDotColor: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
