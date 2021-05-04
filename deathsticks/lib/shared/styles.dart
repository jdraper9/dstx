import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: mainBlueLighter,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainBlue, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainBlueDarker, width: 2.0)
  ),
);