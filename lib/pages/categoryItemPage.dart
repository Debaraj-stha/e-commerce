import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:e_commerce/utils/searchBar.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class categoryItemPage extends StatefulWidget {
  const categoryItemPage({super.key, required this.category});
  final String category;
  @override
  State<categoryItemPage> createState() => _categoryItemPageState();
}

class _categoryItemPageState extends State<categoryItemPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    final categoryItem = provider.categoryItems;

    return Scaffold(
      appBar: searchBar(
        isShownIcon: true,
      ),
      body: Column(
        children: [
          Consumer<e_commerceProvider>(builder: (context, value, child) {
            return Container(
              height: 100,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Vertically center the content
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        myTab(0, "Free Delivery", value,"freeDelivery",widget.category),
                        // SizedBox(width: 6,),
                        myTab(1, "Top Sells", value,"sold",widget.category),
                        myTab(2, "New Arrival", value,"newArival",widget.category),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            smallText(
                              text: "Price",
                              color: value.isfilterSelected[3] ||
                                      value.isfilterSelected[4]
                                  ? constraunts.primary
                                  : Colors.black,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_up,
                                    color: value.isfilterSelected[3]
                                        ? constraunts.primary
                                        : Colors.black,
                                  ),
                                  onTap: () {
                                    provider.filterFreeDelivery(3, "",widget.category,
                                        order: 'asc');
                                  },
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: value.isfilterSelected[4]
                                        ? constraunts.primary
                                        : Colors.black,
                                  ),
                                  onTap: () {
                                    provider.filterFreeDelivery(4, "price",widget.category,
                                        order: 'desc');
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Container(
              child: Consumer<e_commerceProvider>(
                  builder: (context, value, child) {
                if (value.lowPriceProduct == null || value.categoryItems == null) {
                  return CircularProgressIndicator();
                } else if (value.lowPriceProduct.isEmpty &&
                    value.categoryItems.isEmpty) {
                  return Center(
                    child: smallText(text: "No product available"),
                  );
                } else {
                  if (value.isfilterSelected[value.selectedFilterIndex??0]) {
                    return GridView.builder(
                      itemCount: value.lowPriceProduct.length,
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent:
                            deviceUtils.getDeviceHeight(context) / 3.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final item = value.lowPriceProduct[index];
                        return productCard(
                          id: item.id,
                          image: item.image,
                          category:item.category,
                          subCategory:item.subCategory,
                      tag:item.tag,
                          text: item.name,
                          price: item.salesPrice.toString(),
                          rating: "4.5/5",
                          oldPrice: item.price.toString(),
                          sold: item.sold.toString(),
                        );
                      },
                    );
                  } else {
                    return GridView.builder(
                      itemCount: categoryItem.length,
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent:
                            deviceUtils.getDeviceHeight(context) / 3.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final item = categoryItem[index];
                        return productCard(
                          id: item.id,
                          image: item.image,
                          tag:item.tag,
                           category:item.category,
                          subCategory:item.subCategory,
                          text: item.name,
                          price: item.salesPrice.toString(),
                          rating: "4.5/5",
                          oldPrice: item.price.toString(),
                          sold: item.sold.toString(),
                        );
                      },
                    );
                  }
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}

Widget myTab(int index, String title, e_commerceProvider value,String filterType,String cat) {
  return InkWell(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: smallText(
            text: title,
            color: value.isfilterSelected[index]
                ? constraunts.primary
                : Colors.black,
            weight: value.isfilterSelected[index]
                ? FontWeight.w700
                : FontWeight.normal,
          )),
      onTap: () {
        value.filterFreeDelivery(index, filterType, cat,
        order:'asc' );
      });
}
