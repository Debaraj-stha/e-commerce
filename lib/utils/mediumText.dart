import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class mediumText extends StatelessWidget {
  const mediumText({super.key,required this.text,required this.color});
final String text;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: 25),);
  }
}