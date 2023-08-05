import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class singleReview extends StatelessWidget {
  const singleReview({super.key,required this.name,required this.date,required this.text,this.image});
final String name;
final String date;
final String text;
final String?image;
  @override
  Widget build(BuildContext context) {
    return   Container(
            padding: EdgeInsets.all(8),
         
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallText(text: name,color: Colors.black,weight: FontWeight.w700,),
                        SizedBox(width: 5,),
                        smallText(text: date),
                      ],
                    ),
                    Icon(Icons.star,color: constraunts.primary,)
                  ],
                ),
                smallText(
                    text:text),
              image!=null?  Container(
                  height: 150,
                  child: GridView.builder(
                    
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                          crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage("asset/welcome2.jpg"),fit: BoxFit.contain)),
                        );
                      }),
                ):Container()
              ],
            ),
          );
  }
}