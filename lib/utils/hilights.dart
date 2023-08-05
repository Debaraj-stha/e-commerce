import 'package:e_commerce/utils/singeHilight.dart';
import 'package:flutter/material.dart';

class hilights extends StatelessWidget {
hilights({Key? key,required this.hilight});
// ignore: prefer_typing_uninitialized_variables
final List<String> hilight;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: List.generate(
          hilight.length,
          (index) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: singleHilights(text: hilight[index]),
          ),
        ),
      ),
    );
  }
}
