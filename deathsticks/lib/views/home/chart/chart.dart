import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathsticks/models/day.dart';
import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<DataPoint<dynamic>> dataPoints = [];

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);
    final DatabaseService db = DatabaseService(uid: person.uid);

    //history
    List<Day> history = [];


    // calc dailyCount from stream
    int dailyCount = 0;
    final dailyEvents = Provider.of<List<Event>>(context) ?? [];
    dailyEvents.forEach((Event e) {
      if (e.isActive) {
        dailyCount += 1;
      }
    });

    // dates
    final now = DateTime.now();
    final fromDate = now.subtract(Duration(days: 28));
    final toDate = now;

    // list of points
    final dateNow = now;
    final date1 = now.subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

     List<DataPoint<dynamic>> dataPointsFromHistory(List<Day> history) {
      // DataPoint<DateTime>(value: 10, xAxis: date1),
      List<DataPoint<dynamic>> points = [];
      history.forEach((day) {
        DateTime dayDate = DateTime(day.year, day.month, day.day);
        int dayCount = day.events.length;
        if (DateTime.now().difference(dayDate).inDays != 0) {
          DataPoint<DateTime> point = DataPoint(value: dayCount.toDouble(), xAxis: dayDate);
          points.add(point);
        } else {
          print('today');
        }
      });
      return points;
    }

    // one time read: History (days before today)
    db.getHistory().then((QuerySnapshot value) => {
      // for each doc, create Day
      value.docs.forEach((QueryDocumentSnapshot doc) {
        //create day, and empty list
        var dateArray = doc.id.split("-");
        Day pastDay = Day(month: int.parse(dateArray[0]), day: int.parse(dateArray[1]), year: int.parse(dateArray[2]));
        List<Event> pastDayEvents = [];
        // for each field, create Event
        doc.data().forEach((key, value) {
          // create Event (if active), push to list
          if(value == true) {
            Event e = Event(timeOfEvent: key, isActive: value);
            pastDayEvents.add(e);
          }
        });
        pastDay.events = pastDayEvents;
        history.add(pastDay);
        setState(() {
          dataPoints = dataPointsFromHistory(history);
        });
        // dataPoints = ;
      })
    });

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
                DataPoint<DateTime>(value: dailyCount.toDouble(), xAxis: dateNow),
                ...dataPoints,
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
