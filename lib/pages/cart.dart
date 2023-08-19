import 'package:e_commerce/controller/dbController.dart';
import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/justForYou.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/quantityHandle.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/productsModel.dart';
import '../utils/appBar.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  dbController? controller;
  @override
  void initState() {
    super.initState();
    controller = dbController();
// controller!.insert(Cart(name: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's s", image: "https://commons.wikimedia.org/wiki/File:Sunflower_from_Silesia2.jpg", color: "Yellow", shopName: "new dummy shopfor test", quantity: 4, perItem: 100, productId:"64b0159e3e651d8601ad82a8" , deliveryCharge: 20, varient: "L",shopId: "64b0159e3e411d8601ad82a9"));
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
   
    provider.getRecomondation(); // Call the loadCartData method here
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context);
    provider.getForYouProduct();
    final cartItem = provider.cart;
    return Scaffold(
      appBar: myAppBar(
        cartItemLength: 4,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                child: Consumer<e_commerceProvider>(
                  builder: (context, value, child) {
                    if (provider.cart.isEmpty) {
                      return Center(
                        child: smallText(
                            text: "You do not have any item in your cart"),
                      );
                    } else if (provider.cart.length == 0) {
                      return CircularProgressIndicator();
                    } else {
                      final groupedCartItems =
                          provider.groupCartItems(provider.cart);
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: groupedCartItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final group = groupedCartItems[index];
                          return Container(
                            margin: EdgeInsets.only(top: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: value.isChecked(group.shopId),
                                      onChanged: (value) {
                                        provider.setChecked(
                                            group.shopId, value!, group.items);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: smallText(
                                          text: "Shop: ${group.shopId}"),
                                    ),
                                  ],
                                ),
                                ...group.items
                                    .map((item) => buildCartItemWidget(
                                        item,
                                        
                                        group.shopId,
                                        provider,
                                        index,
                                        group.items))
                                    .toList(),
                                Divider(
                                    thickness: 4,
                                    color: Color.fromARGB(255, 211, 206, 206)),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 100,),
              smallText(
                text: "For you",
              ),
              justForYou(),
            ],
          ),
          provider.cart.length>0?
          Container(
            padding: EdgeInsets.only(right: 5,top: 5),
              height: 80, // Adjust the height as needed
              color: Color.fromARGB(255, 192, 182, 182),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                      onChanged: (val) {
                        provider.allChecked(val ?? false);
                      },
                      value: provider.getAllSelected()),
                  smallText(text: "All"),
                  Spacer(),
                  Column(
                    children: [
                      smallText(
                        text:
                            "Delivery Charge:RS ${provider.deliveryCharge.toString()}",
                      ),
                      smallText(
                          text:
                              "Product cost:Rs ${provider.totalProductCost.toString()}",
                          ),
                      smallText(
                          text:
                              "total Cost:${provider.totalProductCost + provider.deliveryCharge}")
                    ],
                  ),
                  Spacer(),
                  
                  TextButton(
                    onPressed: () {
                      provider.validateOrder(
                         context);
                         
                    },
                    child: smallText(
                      text: "CheckOut(${provider.checkedProductLength})",
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: constraunts.primary),
                  )
                ],
              )):Container()
        ],
      ),
    );
  }

  Widget buildCartItemWidget(Cart item, String shopId,
      e_commerceProvider provider, int index, List<Cart> items) {
    return InkWell(
      onTap: (){
        // provider.cancelPurchase(item.name, item.image, shopId, item.productId, item.perItem, item.deliveryCharge, item.color, item.varient, item.shopName);
        // provider.ordersProduct("202322", "pending", "https://unsplash.com/photos/8Myh76_3M2U","testing product name", 2, 600, "7775a33");
        // controller!.delete(item.productId);
        // debugPrint(item.productId);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                    onChanged: (value) {
                      provider.setProductChecked(
                          value ?? false, item.productId, item.shopId, items);
                    },
                    value: (provider.isChecked(shopId))
                        ? provider.isChecked(shopId)
                        : provider.getSelectedProduct(item.productId)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.all(8),
                        width: deviceUtils.getDeviceWidth(context),
                        height: 120,
                        child: Row(
                          children: [
                            Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(item.image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smallText(text: item.name),
                                  Row(
                                    children: [
                                      smallText(text: "Brand:None,"),
                                      smallText(text: "Color:Red"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      smallText(text: "Size:L,"),
                                      smallText(text: "instock:4"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      smallText(text: "delivery charge"),
                                      smallText(
                                          text: item.deliveryCharge.toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      smallText(
                                        text: "Rs ${item.perItem.toString()}",
                                        color: constraunts.primary,
                                      ),
                                      quantityHandle(productId:item.productId,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
