import 'package:atlasweather/Utilities/Class/app_top_city.dart';
import 'package:atlasweather/Utilities/Misc/constants.dart';
import 'package:flutter/material.dart';

class AppCityCard extends StatelessWidget {
  final AppCity city;
  final Function()? onPressed;

  AppCityCard(
      this.city, {
        this.onPressed,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: k3x4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kDarkShadeColor,
                image: DecorationImage(
                  image: NetworkImage(city.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kDarkShadeColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                city.name,
                style: TextStyle(
                  color: kNotWhiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}