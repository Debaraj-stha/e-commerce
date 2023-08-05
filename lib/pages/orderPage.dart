import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../utils/smallText.dart';

class orderPage extends StatefulWidget {
  const orderPage({super.key});

  @override
  State<orderPage> createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {

  @override
  Widget build(BuildContext context) {
       final provider=  Provider.of<e_commerceProvider>(context, listen: false);
       provider.updateOrder();
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 2,
          title: smallText(text: "My Orders"),
        ),
        body: Consumer<e_commerceProvider>(
          builder: (context, value, child) {
            if (value.orderList.isEmpty) {
             return Center(
                child: smallText(text: "You do not have any order yet"),
             );
            } else if (value.orderList.length == 0) {
                return CircularProgressIndicator();
             
          
            } else {
              return ListView.builder(
                  itemCount: value.orderList.length,
                  itemBuilder: (context, index) {
                    final product=value.orderList[index];
                    return Row(children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(product.image),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallText(
                              text: product.name,
                              weight: FontWeight.w700,
                              color: Colors.black),
                        
                          Row(
                            children: [
                              smallText(text: "Rs:${product.perItem},"),
                            ],
                          ),
                          Row(
                            children: [
                              
                              smallText(
                                  weight: FontWeight.w700,
                                  text: "${product.quantity}")
                            ],
                          ),
                          Row(
                            children: [
                              smallText(
                                  weight: FontWeight.w700,
                                  text:product.orderAt,
                                  color: constraunts.primary),
                              Spacer(),
                              smallText(
                                  text: "${product.status}",
                                  weight: FontWeight.w600)
                            ],
                          ),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              primary:product.status=="cancelled"?Colors.grey:constraunts.primary
                            ),
                            
                            onPressed: (){
                              bool isTrue=product.status!="cancelled"&&product.status!="delivered";
                              
                              if(isTrue){
                                Order order=Order(name: product.name, image: product.image, color: product.color, quantity: product.quantity, perItem: product.perItem, productId: product.productId, deliveryCharge: product.deliveryCharge, shopName: product.shopName, orderId: product.orderId, orderAt: product.orderAt, varient: product.varient,status: "cancelled");
                                Cart cart=Cart(name: product.name, image:product.image, color:product.color, shopId: product.shopId??"", quantity:product. quantity, perItem:product. perItem, productId:product. productId, deliveryCharge:product. deliveryCharge, shopName: product.shopName, varient:product. varient);
                            provider.cancelOrder(order, product.orderId,cart,context);
                              }
                          }, child: smallText(text:product.status=="cancelled"?product.status!: "cancel order",color: Colors.white,)),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    )
                  ]);
                  });
            }
          },
        ));
  }
}
