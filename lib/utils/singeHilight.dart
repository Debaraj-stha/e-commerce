import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class singleHilights extends StatelessWidget {
  const singleHilights({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            height: 10,
            width: 10,
          ),
          smallText(text: text)
        ],
      ),
    );
  }
}
