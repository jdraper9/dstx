import 'dart:async';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/components/loading_2.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  final DatabaseService db;
  Chart({this.db});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<List<DataPoint<dynamic>>> _dataPoints;

  @override
  void initState() {
    super.initState();
    _dataPoints = widget.db.getDataPoints();
  }

  @override
  Widget build(BuildContext context) {
    // dates
    final now = DateTime.now();
    final fromDate = now.subtract(Duration(days: 28));
    final toDate = now;

    // calc today's dailyCount from stream
    int dailyCount = 0;
    final dailyEvents = Provider.of<List<Event>>(context) ?? [];
    dailyEvents.forEach((Event e) {
      if (e.isActive) {
        dailyCount += 1;
      }
    });

    final reloadStream = Provider.of<String>(context) ?? null;
    print('here');
    print(reloadStream);
    if (reloadStream == 'true') {
      print('yes');
    } else if (reloadStream == 'false') {
      print('no');
    }

    return FutureBuilder<List<DataPoint<dynamic>>>(
        future: _dataPoints,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  child: BezierChart(
                    fromDate: fromDate,
                    bezierChartScale: BezierChartScale.WEEKLY,
                    toDate: toDate,
                    selectedDate: toDate,
                    series: [
                      BezierLine(
                        label: "Score",
                        dataPointFillColor: mainBlueLighter,
                        lineColor: mainRed,
                        // onMissingValue: (dateTime) {
                        //   return 0;
                        // },
                        data: [
                          // DataPoint<DateTime>(value: 10.0, xAxis: now)
                          DataPoint<DateTime>(
                              value: dailyCount.toDouble(), xAxis: now),
                          ...snapshot.data,
                        ],
                      ),
                    ],
                    config: BezierChartConfig(
                      verticalIndicatorStrokeWidth: 1.0,
                      verticalIndicatorColor: mainBlue,
                      showVerticalIndicator: true,
                      backgroundColor: Colors.white,
                      snap: false,
                      xAxisTextStyle: Theme.of(context)
                          .textTheme
                          .overline
                          .apply(color: mainRed),
                      footerHeight: 70.0,
                      bubbleIndicatorTitleStyle: Theme.of(context)
                          .textTheme
                          .overline
                          .apply(color: mainRed),
                      // displayYAxis: true,
                      // stepsYAxis: 20,
                      // yAxisTextStyle: Theme.of(context).textTheme.overline.apply(color: mainRed),
                    ),
                  ),
                )
              : Loading2();
        });
  }
}
