import 'package:bezier_chart/bezier_chart.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final fromDate = now.subtract(Duration(days: 28));
    final toDate = now;

    // list of points
    final date1 = now.subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Event",
              dataPointFillColor: mainBlueLighter,
              lineColor: mainRed,
              onMissingValue: (dateTime) {
                return 0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 2, xAxis: date2),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 1.0,
            verticalIndicatorColor: mainBlue,
            showVerticalIndicator: true,
            backgroundColor: Colors.white,
            snap: false,
            xAxisTextStyle: Theme.of(context).textTheme.overline.apply(color: mainRed),
            footerHeight: 70.0,
            bubbleIndicatorTitleStyle: Theme.of(context).textTheme.overline.apply(color: mainRed),
            // displayYAxis: true,
            // stepsYAxis: 20,
            // yAxisTextStyle: Theme.of(context).textTheme.overline.apply(color: mainRed),
          ),
        ),
      );
   
  }
}
