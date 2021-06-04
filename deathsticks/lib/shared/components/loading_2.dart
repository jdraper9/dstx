import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainBlue,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SpinKitCircle(
            color: mainRed,
            size: 60.0,
          ),
        ),
      ),
    );
  }
}