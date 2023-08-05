import 'package:e_commerce/pages/categoryItemPage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class categoryItem extends StatefulWidget {
  const categoryItem({super.key, required this.image, required this.text,required this.category});
  final String image;
  final String text;
  final String category;
  @override
  State<categoryItem> createState() => _categoryItemState();
}

class _categoryItemState extends State<categoryItem> {
  
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        debugPrint(widget.category);
        final provider=Provider.of<e_commerceProvider>(context,listen: false);
        provider..fetchCategoryItem(widget.category);
        provider.controller.text=widget.category;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => categoryItemPage(category:widget.category)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
      BoxShadow(
      color: Color.fromARGB(255, 192, 186, 186).withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 5,
      offset: Offset(0, 3),
      ),
    ],
            ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: 100,
            
              child: Image(image: NetworkImage(widget.image,),fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: smallText(text: widget.text,weight: FontWeight.w700)),
            )
          ],
        ),
      ),
    );
  }
}
