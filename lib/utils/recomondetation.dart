import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({Key? key, required this.recommended}) : super(key: key);
  final List<RecommendedProduct> recommended;

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  PageController controller = PageController();
  late List<List<RecommendedProduct>> _pages;
  int itemsPerPage = 3;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    generatePages();
  }

  void generatePages() {
    _pages = List.generate(
      (widget.recommended.length / itemsPerPage).ceil(),
      (index) {
        int start = index * itemsPerPage;
        int end = (index + 1) * itemsPerPage;
        int pageEnd =
            end < widget.recommended.length ? end : widget.recommended.length;
        return widget.recommended.sublist(start, pageEnd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
             color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 192, 186, 186).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
         
          padding: EdgeInsets.only(left: 4,right: 4),
          height: 200,
          child: PageView.builder(
            controller: controller,
            itemCount: _pages.length,
            onPageChanged: (int value) {
              setState(() {
                currentPage = value;
              });
            },
            itemBuilder: (context, index) {
              final page = _pages[index];

              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: deviceUtils.getDeviceHeight(context) / 5,
                  crossAxisCount: 3, // Display three images per row
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8, // Add spacing between images
                ),
                itemCount:
                    page.length, // Use page.length instead of _pages.length
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(page[i].images),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      smallText(
                        color: Colors.black,
                        weight: FontWeight.w700,
                        text: page[i].name,
                      ),
                      smallText(
                        text: "Rs 7999",
                        color: constraunts.primary,
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: SmoothPageIndicator(
              controller: controller,
              count: _pages.length,
              effect: WormEffect(),
            ),
          ),
        ),
      ],
    );
  }
}
