import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class shopCardd extends StatefulWidget {
  const shopCardd({super.key,required this.name});
final String name;
  @override
  State<shopCardd> createState() => _shopCarddState();
}

class _shopCarddState extends State<shopCardd> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
    padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 40,backgroundImage: AssetImage("asset/welcome2.jpg"),),
              smallText(text: widget.name)
            ],
          ),
          Row(
            children: [
                BuildText("Positive seller Ratings", "90%"),
                BuildText("Ship on Time", "100%"),
                BuildText("Chat Response time", "97%")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(side: BorderSide(color: constraunts.primary)))
                ),
                onPressed: (){
          
              }, child: smallText(text: "Follow",color: constraunts.primary,)),
              SizedBox(width: 10,),
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(side: BorderSide(color: constraunts.primary)))
                ),
                onPressed: (){
          
              }, child: smallText(text: "Visit Store",color: constraunts.primary,))
            ],
          )
        ],
      ),
    );
  }
}
Widget BuildText(String text,String number){
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        mediumText(text: number, color: Colors.black),
        smallText(text: text)
      ],
    ),
  );
}