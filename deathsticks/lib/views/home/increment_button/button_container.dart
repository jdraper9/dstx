import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: mainRedLighter, width: .3),
      ),
    );
  }
}
