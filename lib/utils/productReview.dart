import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/utils/singleReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../model/productsModel.dart';
import '../provider/providers.dart';

class productReview extends StatelessWidget {
  const productReview({super.key, required this.review});
  final review;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Consumer<e_commerceProvider>(
          builder: (context, value, child) {
            if (value.isReviewShow) {
              return Column(
                  children: List.generate(
                      review.length,
                      (index) => Padding(
                          padding: EdgeInsets.all(8),
                          child: singleReview(
                            date: DateTime.now().toString(),
                            name: review[index].user[0].name,
                            text: review[index].review,
                          ))));
            } else {
              return Column(
                  children: List.generate(
                      review.length > 3? 3 : review.length,
                      (index) => Padding(
                          padding: EdgeInsets.all(8),
                          child: singleReview(
                            date: DateTime.now().toString(),
                            name: review[index].user[0].name,
                            text: review[index].review,
                          ))));
            }
          },
        ));
  }
}
