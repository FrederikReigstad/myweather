import 'package:Weather/widgets/weekly_forecast_list.dart';
import 'package:Weather/widgets/windspeed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/app_state.dart';
import '../repositories/forecast_repository.dart';
import '../utils/position.dart';
import 'forecast_app_bar.dart';
import 'hourly_forecast_list.dart';
import 'settings_screen.dart';

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({Key? key}) : super(key: key);

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  int _selectedIndex = 0;
  final _tabs = [
    WeeklyForecastList.new,
    HourlyForecastList.new,
    WindSpeedList.new,
  ];

  @override
  Widget build(BuildContext context) {
    final responce = ResponsiveWrapper.of(context);
    if (responce.isLargerThan(TABLET)) {
      return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                extended: true,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(Icons.calendar_view_week),
                      label: Text('Weekly')),
                  NavigationRailDestination(
                      icon: Icon(Icons.calendar_view_day),
                      label: Text('Hourly')),
                  NavigationRailDestination(
                      icon: Icon(Icons.wind_power), label: Text('Wind Speed')),
                ],
              ),
              Expanded(child: _buildBodyWeb(context)),
            ],
          ),
          appBar: AppBarWeb(
              onSettings: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ))));
    } else {
      return Scaffold(
          body: _buildBodyAndroid(context),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_week), label: 'Weekly'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_day), label: 'Hourly'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wind_power), label: 'Wind Speed'),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ));
    }
  }

  Widget _buildBodyAndroid(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final repo = Provider.of<ForecastRepository>(context);
    return FutureBuilder(
      future: _restore(state, repo),
      builder: (context, snapshot) => RefreshIndicator(
        onRefresh: () async {
          await _refresh(state, repo);
          setState(() {});
        },
        child: CustomScrollView(
          slivers: <Widget>[
            const ForecastAppBar(),
            _buildTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWeb(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final repo = Provider.of<ForecastRepository>(context);
    return FutureBuilder(
        future: _restore(state, repo),
        builder: (context, snapshot) => Column(
              children: [
                _buildTab(),
              ],
            ));
  }

  Future _restore(AppState state, ForecastRepository repo) async {
    await state.restore();
    if (state.isStale()) {
      await _refresh(state, repo);
    }
  }

  Future _refresh(AppState state, ForecastRepository repo) async {
    var latitude = state.location?.latitude;
    var longitude = state.location?.longitude;
    if (state.location == null) {
      final position = await determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    }
    final data =
        await repo.getForecast(latitude: latitude!, longitude: longitude!);
    await state.setForecast(data);
  }

  Widget _buildTab() {
    return _tabs
        .elementAt(_selectedIndex)
        .call(key: ValueKey('tab-$_selectedIndex'));
  }
}
