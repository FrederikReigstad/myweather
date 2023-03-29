import 'package:Weather/models/daily_forecast.dart';
import 'package:Weather/models/hourly_forecast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/app_state.dart';
import '../server.dart.bak';

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({Key? key}) : super(key: key);

  Widget buildCard(DailyForecast forecast,BuildContext context){
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 100.0,
            width: 100.0,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: <Color>[
                        Colors.grey[800]!,
                        Colors.transparent
                      ],
                    ),
                  ),
                  child: Image.asset(
                    'assets/' + forecast.weathercode.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    forecast.time.day.toString(),
                    style: textTheme.headline2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    forecast.getWeekday(),
                    style: textTheme.headline6,
                  ),
                  const SizedBox(height: 10.0),
                  Text(forecast.weathercode.description),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  '${forecast.temperature_2m_max} | ${forecast
                      .temperature_2m_min} C',
                  style: textTheme.subtitle1,
                ),
                Text(
                  '${forecast.windspeed_10m_max} Max m/s',
                  style: textTheme.subtitle1,
                ),
                Text(
                  '${forecast.windgusts_10m_max} Gust m/s',
                  style: textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final forecasts = Provider.of<AppState>(context).dailyForecast;
    final responce = ResponsiveWrapper.of(context);
    if(responce.isLargerThan(TABLET)) {
      //web
      return Column(children: [
        for (final forecast in forecasts) buildCard(forecast,context),
      ],);
    }
    else{
      // Android
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final forecast = forecasts[index];
            return Card(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: <Color>[
                                Colors.grey[800]!,
                                Colors.transparent
                              ],
                            ),
                          ),
                          child: Image.asset(
                            'assets/' + forecast.weathercode.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Text(
                            forecast.time.day.toString(),
                            style: textTheme.headline2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            forecast.getWeekday(),
                            style: textTheme.headline6,
                          ),
                          const SizedBox(height: 10.0),
                          Text(forecast.weathercode.description),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          '${forecast.temperature_2m_max} | ${forecast
                              .temperature_2m_min} C',
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          '${forecast.windspeed_10m_max} Max m/s',
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          '${forecast.windgusts_10m_max} Gust m/s',
                          style: textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: forecasts.length,
        ),
      );
    }
  }
}
