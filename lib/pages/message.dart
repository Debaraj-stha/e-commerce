import 'package:e_commerce/constraints/khalti.dart';
import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/myCancellation.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class myMessagePage extends StatefulWidget {
  const myMessagePage({super.key});

  @override
  State<myMessagePage> createState() => _myMessagePageState();
}

class _myMessagePageState extends State<myMessagePage> {
  @override
  constraunts? myConstraints;
  void initState() {
    // TODO: implement initState
    myConstraints = constraunts();
    myConstraints!.initOneSignal(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    provider.getCancelPurchase();
    provider.getMessage();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        elevation: 2,
        title: smallText(text: "Message"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smallText(
              text: "Your Cancellation",
              weight: FontWeight.w700,
            ),
            myCancellation(),
            Consumer<e_commerceProvider>(builder: ((context, value, child) {
              if (value.myMessage.length == 0) {
                return CircularProgressIndicator();
              } else if (value.myMessage.isEmpty) {
                return Center(
                  child: smallText(text: "No message yet"),
                );
              } else {
                return Container(
                    color: Colors.grey,
                    child: Wrap(
                      children: List.generate(value.myMessage.length, (index) {
                        final message=value.myMessage[index];
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black26, width: 1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: constraunts.primary,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      smallText(
                                        text: message.title,
                                        weight: FontWeight.w700,
                                      ),
                                      smallText(text: message.created.toString())
                                    ],
                                  ),
                                ],
                              ),
                              smallText(
                                  text:
                                    message.description)
                            ],
                          ),
                        );
                      }),
                    ));
              }
            }))
          ],
        ),
      ),
    );
  }
}
