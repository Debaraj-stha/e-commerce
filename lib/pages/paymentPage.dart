import 'package:e_commerce/constraints/esewa.dart';
import 'package:e_commerce/constraints/khalti.dart';
import 'package:e_commerce/model/constraints.dart';

import 'package:e_commerce/utils/message.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:esewa_pnp_forked/esewa.dart';
import 'package:esewa_pnp_forked/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class paymentPage extends StatefulWidget {
  const paymentPage({super.key});

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  @override
  onTap() {
    debugPrint("clicked");
    // Navigator.push(context,MaterialPageRoute(builder: (context)=>khaltiPage()));
  }

  khaltiPay() {
    PaymentConfig config = PaymentConfig(
        amount: 20 * 100, productIdentity: "3322", productName: "product name");
    void onSuccess(PaymentSuccessModel model) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Payment successful"),
                actions: [
                  SimpleDialogOption(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    }

    void onFailure(PaymentFailureModel failure) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Payment Failure"),
                actions: [
                  SimpleDialogOption(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    }

    KhaltiScope.of(context).pay(
        config: config,
        onSuccess: onSuccess,
        onFailure: onFailure,
        preferences: [
          PaymentPreference.khalti,
          PaymentPreference.connectIPS,
          // PaymentPreference.mobileBanking
        ],
        onCancel: onCancel);
  }

  void onCancel() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Payment Failure"),
              actions: [
                SimpleDialogOption(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  ESewaPnp? esewapng;
  final ESewaConfiguration configuration = ESewaConfiguration(
      clientID: esewaConstrain.clientID,
      secretKey: esewaConstrain.secretKey,
      environment: ESewaConfiguration.ENVIRONMENT_TEST);
  @override
  void initState() {
    // TODO: implement initState
    esewapng = ESewaPnp(configuration: configuration);
    super.initState();
  }

  String callBackUrl = "https://example.com";
  double amount = 100;
  String productId = "123";
  String productName = "testname";
  void onSuccess(result) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(result.message.toString())));
  }

  void onFailure(error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.message.toString())));
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: smallText(text: "Select payment method"),
        elevation: 2,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: ListView(padding: EdgeInsets.all(8), children: [
                    smallText(
                      text: "Payment Methods",
                      weight: FontWeight.w700,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    ESewaPaymentButton(
                      esewapng!,
                      amount: amount,
                      productId: productId,
                      productName: productName,
                      callBackURL: callBackUrl,
                      onSuccess: onSuccess,
                      onFailure: onFailure,
                      labelBuilder: (double? amount, Widget? esewaLogo) {
                        return Text("Pay Rs ${amount}");
                      },
                    ),
                    customListTile(
                      "eSewa mobile wallet",
                      "esewa.png",
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    InkWell(
                      onTap: khaltiPay,
                      child: customListTile(
                        "Khalti mobile wallet",
                        "khalti.jpg",
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    customListTile(
                      "Cash on delivery",
                      "cash.jpg",
                    ),
                    TextButton(
                        onPressed: () {
                          provider.orderProduct(context);
                          for (var i = 0;
                              i <
                                  provider
                                      .getCheckedCartItems(provider.cart)
                                      .length;
                              i++) {
                            // provider.purchaseProduct(
                            //     provider.getCheckedCartItems(provider.cart)[i]);
                          }
                        },
                        child: smallText(text: "buy"))
                  ]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 213, 208, 208),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallText(
                  text: "Total Ammount:",
                  weight: FontWeight.w700,
                ),
                smallText(
                  text: "Rs 1000",
                  weight: FontWeight.w700,
                  color: constraunts.primary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget customListTile(String text, String image) {
  return Row(
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("asset/${image}"))),
      ),
      smallText(
        text: text,
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios)
    ],
  );
}
