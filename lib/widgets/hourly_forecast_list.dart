import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:Weather/models/hourly_forecast.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/app_state.dart';
import '../server.dart.bak';

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final forecast = state.hourlyForecast;
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Card(child: TemperatureChart(forecast)),
        Card(child: PrecipitationChart(forecast)),
      ]),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  final List<HourlyForecast> forecast;
  const TemperatureChart(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Temperature'),
      primaryXAxis: DateTimeAxis(dateFormat: DateFormat('H')),
      primaryYAxis: NumericAxis(title: AxisTitle(text: '°C')),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: [
        SplineSeries(
            dataSource: forecast.take(24).toList(),
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.temperature_2m,
            legendItemText: 'Air temp'),
        SplineSeries(
            dataSource: forecast.take(24).toList(),
            xValueMapper: (element, index) => element.time,
            yValueMapper: (element, index) => element.apparent_temperature,
            legendItemText: 'Feels-like'),
      ],
    );
  }
}

class PrecipitationChart extends StatelessWidget {
  final List<HourlyForecast> forecast;
  const PrecipitationChart(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Precipitation'),
      primaryXAxis: DateTimeAxis(dateFormat: DateFormat('H')),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'mm')),
      series: [
        ColumnSeries(
          // forecast.toList takes the houres we plot in the graff
          dataSource: forecast.take(24).toList(),
          xValueMapper: (datum, index) => datum.time,
          yValueMapper: (datum, index) => datum.precipitation,
          pointColorMapper: (datum, index) => Color.alphaBlend(
            Colors.white.withOpacity(datum.precipitation_probability / 100),
            Colors.blueGrey,
          ),
        )
      ],
    );
  }
}
