import 'package:e_commerce/utils/productQuestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class questionPage extends StatefulWidget {
  const questionPage({super.key,required this.question,required this.shop,required this.productId});
  final question;
  final shop;
  final String productId;
  @override
  State<questionPage> createState() => _questionPageState();
}

class _questionPageState extends State<questionPage> {
  TextEditingController? controller;
  FocusNode?focusNode;
  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    focusNode!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final provider=Provider.of<e_commerceProvider>(context,listen: false);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // productQuestion(question: widget.question, shop: widget.shop),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Card(
                  color: Color.fromARGB(255, 200, 194, 194),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                          hintText: "Type question here...",
                          border: InputBorder.none,
                          suffix: InkWell(
                            child: Icon(Icons.telegram, color: Colors.blue),
                            onTap: () {
                              if (controller!.text.isEmpty) {
                                debugPrint("e,mpty");
                              } else {
                                provider.postProductQuestion(widget.shop.id,widget.productId,controller!.text,context);
                                focusNode!.unfocus();
                                controller!.clear();
                              }
                            },
                          )),
                    ),
                  )),
            ))
      ],
    ));
  }
}
