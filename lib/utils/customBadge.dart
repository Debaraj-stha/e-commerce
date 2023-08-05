import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customBadge(String value){
  return  Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(
        minWidth: 18,
        minHeight: 18,
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 12, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
}