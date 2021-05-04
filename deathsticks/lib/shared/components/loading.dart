import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainBlue,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SpinKitPumpingHeart(
            color: mainRed,
            size: 60.0,
          ),
        ),
      ),
    );
  }
}
