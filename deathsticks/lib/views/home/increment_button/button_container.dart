import 'package:deathsticks/shared/constants/colors.dart';
import 'package:deathsticks/views/home/increment_button/button.dart';
import 'package:deathsticks/views/home/increment_button/daily_count.dart';
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
      child: Row(
        children: [
          Button(),
          DailyCount(),
        ],
      ),
    );
  }
}
