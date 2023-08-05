import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class myReviews extends StatelessWidget {
  const myReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<e_commerceProvider>(context,listen: false);
    
    // provider.insertMyReview(myReview(image: "https://upload.wikimedia.org/wikipedia/commons/4/41/Sunflower_from_Silesia2.jpg",productId: "8729a",rating: 3,review: "this product is very good",reviewAt: DateTime.now().toString()));
    provider.loadMyReview();
    return Scaffold(
      appBar: AppBar(
        title: smallText(text: "My Review"),
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body:Consumer<e_commerceProvider>(builder: (context,value,child){
        if(value.myReviews.length==0){
          return Column(
            children: [
              Center(child: smallText(text: "Yow do not review any product yet"),),
              TextButton(onPressed: (){

              }, child: smallText(text: "Review Now"))
            ],
          );
        }
        else if(value.myReviews.isEmpty){
          return CircularProgressIndicator();
        }
        else{
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: value.myReviews.length,itemBuilder: (context,index){
            final review=value.myReviews[index];
              return Column(children: [
                Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(review.image))),),
                   Expanded(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      smallText(text: "product name goes here",weight: FontWeight.w700,),
                      smallText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley"),
                      smallText(text: review.reviewAt)
                     ,Wrap(children: List.generate(review.rating, (index){
                      return Icon(Icons.star,color: constraunts.primary,);
                     }),)
                     ],),
                   )
                ],
              )],);
          });
        }
      })
    );
  }
}