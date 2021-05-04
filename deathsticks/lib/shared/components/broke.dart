import 'package:flutter/material.dart';

class Broken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Something went wrong... Please try again in a bit.', textDirection: TextDirection.ltr,),
    );
  }
}