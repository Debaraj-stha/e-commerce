import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class smallText extends StatelessWidget {
  const smallText({super.key,required this.text,this.color=Colors.black,this.decoration=TextDecoration.none,this.weight=FontWeight.normal});
final String text;
final Color color;
final  FontWeight weight;
final TextDecoration decoration;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: 16,decoration:decoration ,overflow: TextOverflow.clip,fontWeight: weight),maxLines: 2,);
  }
}