import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/app_state.dart';
import '../models/hourly_forecast.dart';

class WindSpeedList extends StatelessWidget {
  const WindSpeedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final forecast = state.hourlyForecast;
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Card(child: WindChart(forecast)),
        Card(child: WindDirectionChart(forecast)),
      ]),
    );
  }
}


class WindChart extends StatelessWidget {
  final List<HourlyForecast> forecast;

  const WindChart(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Wind Speed'),
      primaryXAxis: DateTimeAxis(dateFormat: DateFormat('H'),interval: 2.00),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'm/s')),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: [
        SplineSeries(
            dataSource: forecast.take(24).toList(),
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.windspeed_10m,
            legendItemText: 'Air Speed'),
      ],
    );
  }
}

class WindDirectionChart extends StatelessWidget {
  final List<HourlyForecast> forecast;
  const WindDirectionChart(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Wind Direction'),
      primaryXAxis: DateTimeAxis(dateFormat: DateFormat('H'),interval: 2.00),
      primaryYAxis: NumericAxis(title: AxisTitle(text: '°Grader')),
      series: [
        SplineSeries(
            dataSource: forecast.take(24).toList(),
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.winddirection_10m,
            legendItemText: 'Wind Direction'),
      ],
    );
  }
}