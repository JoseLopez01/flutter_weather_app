import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:weather_app/extensions/string_extensions.dart';

import 'package:weather_app/constants.dart';
import 'package:weather_app/models/WeatherResponse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nowDate = DateFormat('EEEE, MMM d').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: _getCurrentLocation(),
          builder:
              (BuildContext context, AsyncSnapshot<WeatherResponse> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/icons/undraw_Raining_re_4b55.svg',
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: kDefaultPadding * 2),
                    child: _buildWeatherInfo(snapshot.data!.main.temp.ceil(),
                        snapshot.data!.weather[0].description),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator()],
            );
          },
        ));
  }

  Widget _buildWeatherInfo(int temp, String description) {
    return Card(
      color: kLightGray,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              '$temp°',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              description.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: kDefaultPadding, bottom: kDefaultPadding),
            child: Text(
              nowDate,
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }

  Future<WeatherResponse> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$API_KEY&units=metric'));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Something went wrong');
  }
}
