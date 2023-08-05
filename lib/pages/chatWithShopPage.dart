import 'package:e_commerce/constraints/khalti.dart';
import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class chatWithShopPage extends StatefulWidget {
  const chatWithShopPage(
      {super.key, required this.shopName, required this.shopId});
  final String shopName;
  final String shopId;
  @override
  State<chatWithShopPage> createState() => _chatWithShopPageState();
}

class _chatWithShopPageState extends State<chatWithShopPage> {
  TextEditingController? controller;
  FocusNode? focusnode;
  ScrollController? scrollController;

  @override
  void initState() {
    controller = new TextEditingController();
    focusnode = new FocusNode();
    scrollController = new ScrollController();
    super.initState();
  }
void scrollToBottom() {
    // Use this method to scroll to the bottom of the ListView
    if (scrollController != null && scrollController!.hasClients) {
      scrollController!.animateTo(
        scrollController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    focusnode!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
     
    provider.getUserMessage(widget.shopId);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 1,
        backgroundColor: Colors.white,
        title: smallText(text: widget.shopName),
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<e_commerceProvider>(
            builder: (context, value, child) {
              if (value.yourMessage.isEmpty) {
                return CircularProgressIndicator();
              } else if (value.yourMessage.length == 0) {
                return Center(
                  child: smallText(text: "You do not have any message yet!!"),
                );
              } else {
                return ListView.builder(
                    controller: scrollController,
                    itemCount: value.yourMessage.length,
                    itemBuilder: (context, index) {
                      final data = value.yourMessage[index];
                      String message = data.message;
                      String at = data.at.toString();
                      bool isSender = data.isSender;
                      return buildMessage(message, at, isSender);
                    });
              }
            },
          )),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.only(left: 3, right: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: TextFormField(
              focusNode: focusnode,
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                prefixIconColor: Colors.black,
                suffix: InkWell(
                  onTap: () {
                    String message = controller!.text;
                    provider.sendMessageToShop(widget.shopId, message);
                    controller!.clear();
                    // focusnode!.unfocus();
                   scrollToBottom();
                  },
                  child: Icon(
                    Icons.telegram,
                    color: Colors.black,
                  ),
                ),
                hintText: "Type here...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage(String message, String at, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSender ? Colors.indigo : constraunts.primary,
        ),
        width: deviceUtils.getDeviceWidth(context) / 2.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smallText(
              text: message,
              color: Colors.white,
            ),
            smallText(
              text: at,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
