import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class singleProductReview extends StatefulWidget {
  const singleProductReview({super.key, required this.name, required this.id});
  final String name;
  final String id;
  @override
  State<singleProductReview> createState() => _singleProductReviewState();
}

class _singleProductReviewState extends State<singleProductReview> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: smallText(text: widget.name),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black)),
              child: TextFormField(
                maxLines: 3,
                controller: _controller,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
               
                  prefixIconColor: Colors.black,
                  hintText: "Review",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
      
              ),
              child: smallText(text: "Post",color: Colors.white,),)
          ],
          
        ),
      ),
    );
  }
}
