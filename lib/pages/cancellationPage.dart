import 'package:e_commerce/utils/myCancellation.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class cancellationPage extends StatelessWidget {
  const cancellationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2,
        title: smallText(text: "Cancellation"),
      ),
      body: myCancellation(),
    );
  }
}