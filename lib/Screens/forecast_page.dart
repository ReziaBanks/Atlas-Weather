import 'package:atlasweather/Components/basic_components.dart';
import 'package:atlasweather/Utilities/Class/app_forecast.dart';
import 'package:atlasweather/Utilities/Misc/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:atlasweather/Utilities/Misc/extension.dart';

class ForecastPage extends StatefulWidget {
  final AppForecast forecast;
  ForecastPage(this.forecast);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  DateTime? _day;
  ListElement? _element;
  TextStyle basicStyle = TextStyle(
    fontSize: 17,
    color: kNotWhiteColor,
  );

  String getTemp(){
    ListElement? element = _element;
    if(element != null){
      return '${element.main.temp.toInt()}';
    }
    return '-';
  }

  String getTempDescription(){
    ListElement? element = _element;
    if(element != null){
      List<Weather> weatherList = element.weather;
      if(weatherList.isNotEmpty){
        return weatherList.first.main;
      }
    }
    return '';
  }


  List<ListElement> getFilteredElements(){
    AppForecast forecast = widget.forecast;
    DateTime? day = _day;
    List<ListElement> elements = [];

    if(day != null){
      elements = forecast.list.where((element) => element.dtTxt.isSameDate(day)).toList();
    }

    return elements;
  }

  @override
  Widget build(BuildContext context) {
    AppForecast forecast = widget.forecast;
    ListElement? element = _element;
    DateTime? day = _day;
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context) ? AppBackIconButton() : null,
        centerTitle: true,
        title: Text(
          '${forecast.city.name} Forecast',
          style: kAppBarTextStyle,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 70),
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            height: 182,
            decoration: BoxDecoration(
              color: kDarkShadeColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: '${getTemp()}°',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 100,
                    fontWeight: FontWeight.w500,
                    fontFamily: kJosefinSans,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: getTempDescription(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          Text('Atlas - Day', style: basicStyle),
          SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 5 / 2.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: forecast.uniqueDays.length,
            itemBuilder: (BuildContext context, index) {
              DateTime dayValue = forecast.uniqueDays[index];
              String formattedDate = DateFormat('EEEEE', 'en_US').format(dayValue);
              return AppPile(
                formattedDate,
                color: day != null && day.isSameDate(dayValue) ? kPrimaryColor : kDarkShadeColor,
                onPressed: () {
                  setState(() {
                    _day = dayValue;
                    _element = null;
                  });
                },
              );
            },
          ),
          SizedBox(height: 35),
          Text('Atlas - Time', style: basicStyle),
          SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 5 / 2.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: getFilteredElements().length,
            itemBuilder: (BuildContext context, index) {
              ListElement elementValue = getFilteredElements()[index];
              String formattedDate = DateFormat('hh:mm a').format(elementValue.dtTxt);
              return AppPile(
                formattedDate,
                color: _element == elementValue ? kPrimaryColor : kDarkShadeColor,
                onPressed: () {
                  setState(() {
                    _element = elementValue;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppPile extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onPressed;

  AppPile(
    this.title, {
    this.color = kDarkShadeColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kWhiteColor,
              height: 1.3,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
