import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/singleQuestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class productQuestion extends StatelessWidget {
  const productQuestion(
      {super.key, required this.question, required this.shop});
  final question;
  final shop;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false).isQuestionShow;
    return Container(
        color: Colors.white,
        child:Consumer<e_commerceProvider>(builder: (context,value,child){
          if(value.isQuestionShow){
            return Column(
          children: List.generate(
             question.length,
              (index) => singleQuestion(
                  question: question[index].question,
                  name: question[index].user[0].name,
                  date: "203738",
                  answer: question[index].answer,
                  shop: shop)),
        );
          }
          else{
            return Column(
          children: List.generate(
              question.length > 3 ? 3: question.length,
              (index) => singleQuestion(
                  question: question[index].question,
                  name: question[index].user[0].name,
                  date: "203738",
                  answer: question[index].answer,
                  shop: shop)
          )
            );
          }

        
  }
        )
    );
  }
}
