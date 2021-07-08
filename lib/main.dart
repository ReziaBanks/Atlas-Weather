import 'package:atlasweather/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'Utilities/Misc/constants.dart';

void main() {
  runApp(AtlasWeather());
}

class AtlasWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlas Weather',
      theme: ThemeData(
        fontFamily: kJosefinSans,
        scaffoldBackgroundColor: kDarkBackgroundColor,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kWhiteColor,
          ),
          brightness: Brightness.dark,
        ),
      ),
      home: HomePage(),
    );
  }
}