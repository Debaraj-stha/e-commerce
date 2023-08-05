import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/pages/cancellationPage.dart';
import 'package:e_commerce/pages/loginPage.dart';
import 'package:e_commerce/pages/message.dart';
import 'package:e_commerce/pages/myReview.dart';
import 'package:e_commerce/pages/orderPage.dart';
import 'package:e_commerce/pages/receivePage.dart';
import 'package:e_commerce/pages/returnPage.dart';
import 'package:e_commerce/pages/reviewPage.dart';
import 'package:e_commerce/utils/iconButtgon.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    provider.getPurchaseList();
    provider.getOrdersList();
    provider.getUser();
    provider.getToReceiveList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: constraunts.primary,
          elevation: 0,
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.person),
              ),
              SizedBox(
                width: 4,
              ),
              Consumer<e_commerceProvider>(builder: ((context, value, child) {
                if(value.myUser.isEmpty){
                  return smallText(text: "Welcome");
                }
                else if(value.myUser.length==0){
                  return smallText(text: "Loading");
                }
                else{
               return smallText(text:value.myUser[0].name, color: Colors.white);
                }
              }))
              
            ],
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 6),
              child: Icon(Icons.settings),
            )
          ],
        ),
        body: Container(
          child: ListView(children: [
            Container(
              color: Colors.red,
              child: Container(
                  height: deviceUtils.getDeviceHeight(context) / 5,
                  child: Consumer<e_commerceProvider>(builder: (context,value,child){
                    if(value.myUser.isEmpty){
                      return TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => loginPage()));
                    },
                    child: 
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(constraunts.primary),
                    ),
                  );
                    }
                    else{
                      return Container(color: constraunts.primary, height: deviceUtils.getDeviceHeight(context) / 5,);
                    }
                  },)
                  ),
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(255, 169, 166, 166),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(text: "My orders"),
                  InkWell(
                    child: smallText(
                      text: "View all",
                      color: constraunts.primary,
                    ),
                    onTap: () {
                      provider.getOrdersList();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>orderPage()));
                    },
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(255, 169, 166, 166),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => receivePage()));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 20,
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red),
                                  child: Consumer<e_commerceProvider>(
                                    builder: (context, value, child) {
                                      return Center(
                                          child: smallText(
                                        text: value.orderLength.toString(),
                                        color: Colors.white,
                                      ));
                                    },
                                  )),
                            ),
                            iconButton(icon: Icons.delivery_dining, text: "To Review")
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => returnPage()));
                          },
                          child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 20,
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red),
                                  child: Consumer<e_commerceProvider>(
                                    builder: (context, value, child) {
                                      return Center(
                                          child: smallText(
                                        text: value.purchaseLength.toString(),
                                        color: Colors.white,
                                      ));
                                    },
                                  )),
                            ),
                            iconButton(icon: Icons.payment, text: "To Return")
                          ],
                        ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => reviewPage()));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 20,
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red),
                                  child: Consumer<e_commerceProvider>(
                                    builder: (context, value, child) {
                                      return Center(
                                          child: smallText(
                                        text: value.purchaseLength.toString(),
                                        color: Colors.white,
                                      ));
                                    },
                                  )),
                            ),
                            iconButton(icon: Icons.reviews, text: "To Review")
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.getCancelPurchase();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cancellationPage()));
                        },
                        child: iconButton(
                            icon: Icons.playlist_remove,
                            text: "My Cancellations"),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(255, 169, 166, 166),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: smallText(text: "Services"),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: (){
provider.sendSMSTo("high there", ['+9779819336010']);
                      }, child: smallText(text: "send sms")),
                      InkWell(child: iconButton(icon: Icons.message, text: "My Messages"),onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => myMessagePage()));
                      },),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>myReviews()));
                        },
                        child: iconButton(
                            icon: Icons.reviews_outlined, text: "My Reviews"),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ]),
        ));
  }
}
