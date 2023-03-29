import 'package:flutter/material.dart';
import 'package:Weather/widgets/settings_screen.dart';

const String headerImage = 'assets/header.jpeg';

class ForecastAppBar extends StatelessWidget {
  const ForecastAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: Colors.teal[800],
      expandedHeight: 200.0,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ));
            },
            icon: const Icon(Icons.settings))
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text("Weather"),
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: <Color>[Colors.teal[800]!, Colors.transparent],
            ),
          ),
          child: Image.asset(
            'assets/header.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class AppBarWeb extends AppBar {
   final VoidCallback onSettings;
   Size get preferredSize {
     final width = super.preferredSize.width;
     return Size(width, 200);
   }

  AppBarWeb({required this.onSettings})
      : super(
          backgroundColor: Colors.teal[800],
          actions: [
            IconButton(
                onPressed: () {
                  onSettings.call();

                },
                icon: const Icon(Icons.settings))
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("Weather"),
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
              StretchMode.blurBackground,
            ],
            background: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: <Color>[Colors.teal[800]!, Colors.transparent],
                ),
              ),
              child: Image.asset(
                'assets/header.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
}
