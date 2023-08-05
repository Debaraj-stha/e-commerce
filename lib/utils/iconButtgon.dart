import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class iconButton extends StatefulWidget {
  const iconButton({super.key,required this.icon,required this.text});
final IconData icon;
final String text;
  @override
  State<iconButton> createState() => _iconButtonState();
}

class _iconButtonState extends State<iconButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          
          children: [
            Icon(widget.icon),
           smallText(text: widget.text),
          ],
        ),
      ),
    );
  }
}