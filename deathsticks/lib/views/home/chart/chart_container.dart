import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: mainRedLighter, width: .3),
      ),
    );
  }
}
