import 'package:atlasweather/Utilities/Misc/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class AppBackIconButton extends StatelessWidget {
  final Color color;
  AppBackIconButton({this.color = kWhiteColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        LineIcons.angleLeft,
        size: 24,
        color: color,
      ),
    );
  }
}

class AppProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: Colors.grey,
      size: 40.0,
    );
  }
}