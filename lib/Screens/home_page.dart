import 'dart:convert';
import 'package:atlasweather/Components/basic_components.dart';
import 'package:atlasweather/Components/city_components.dart';
import 'package:atlasweather/Screens/forecast_page.dart';
import 'package:atlasweather/Utilities/Class/app_forecast.dart';
import 'package:atlasweather/Utilities/Class/app_top_city.dart';
import 'package:atlasweather/Utilities/Misc/constants.dart';
import 'package:atlasweather/Utilities/Misc/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showSpinner = false;
  List<AppCity> _cityList = AppData().cityList;

  Future<void> fetchForecast(String city) async {
    setState(() {
      _showSpinner = true;
    });
    try {
      final String url = 'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$kWeatherApiKey&units=metric';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        AppForecast forecast = AppForecast.fromJson(jsonDecode(response.body));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForecastPage(forecast),
          ),
        );
      } else {
        throw Exception('Failed to load album');
      }
    }
    catch(e){
      print(e);
      final snackBar = SnackBar(content: Text('An Error Occurred'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double contentWidth = phoneWidth - 50;
    double cardWidth = (contentWidth - 15) / 2;
    double cardHeight = (cardWidth * 4 / 3) + 50;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      color: kBlackColor,
      opacity: 0.5,
      progressIndicator: AppProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Atlas Weather - Top Cities',
            style: kAppBarTextStyle,
          ),
          centerTitle: true,
          // centerTitle: false,
        ),
        body: GridView.builder(
          padding: kAppPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: cardWidth / cardHeight,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: _cityList.length,
          itemBuilder: (BuildContext context, index) {
            AppCity city = _cityList[index];
            return AppCityCard(
              city,
              onPressed: () async{
                await fetchForecast(city.name);
              },
            );
          },
        ),
      ),
    );
  }
}