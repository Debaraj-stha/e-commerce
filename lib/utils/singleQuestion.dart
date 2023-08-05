import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class singleQuestion extends StatelessWidget {
  const singleQuestion(
      {super.key,
       this.answer,
      required this.question,
      required this.shop,
      required this.name,
      required this.date});
  final String question;
  final String name;
  final String?answer;
  final String date;
  final shop;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(child: Icon(Icons.question_mark_rounded),
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.circular(15)
                      ),),
                      smallText(text: name,color: Colors.black,weight: FontWeight.w700,),
                      smallText(text: date),
                    ],
                  ),
                  
                ],
              ),
              smallText(text: question),
            ]),
            answer!=null?
            Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.question_answer),
                      ),
                      smallText(text: shop.name,color: Colors.black,weight: FontWeight.w700),
                      SizedBox(width: 5,),
                      smallText(text: date,)
                    ],
                  ),
                  
                ],
              ),
              smallText(text:answer??""),
            ]):Container()
          ],
        )
        );
  }
}
