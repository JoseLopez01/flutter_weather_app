import 'dart:developer';

class Coords {
  final double lon;
  final double lat;

  Coords({required this.lat, required this.lon});

  factory Coords.fromJson(Map<String, dynamic> json) {
    return Coords(lat: json['lat'], lon: json['lon']);
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity']);
  }
}

class Wind {
  final double speed;
  final int deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'], deg: json['deg']);
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }
}

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys(
      {required this.country,
      required this.id,
      required this.sunrise,
      required this.sunset,
      required this.type});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
        country: json['country'],
        id: json['id'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        type: json['type']);
  }
}

class WeatherResponse {
  final int id;
  final int dt;
  final int cod;
  final int timezone;
  final int visibility;
  final String name;
  final String base;
  final Coords coord;
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final Sys sys;

  WeatherResponse(
      {required this.base,
      required this.clouds,
      required this.cod,
      required this.coord,
      required this.dt,
      required this.id,
      required this.main,
      required this.name,
      required this.sys,
      required this.timezone,
      required this.visibility,
      required this.weather,
      required this.wind});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
        base: json['base'],
        clouds: Clouds.fromJson(json['clouds']),
        cod: json['cod'],
        coord: Coords.fromJson(json['coord']),
        dt: json['dt'],
        id: json['id'],
        main: Main.fromJson(json['main']),
        name: json['name'],
        sys: Sys.fromJson(json['sys']),
        timezone: json['timezone'],
        visibility: json['visibility'],
        weather: List<Weather>.from(json['weather'].map((item) => Weather.fromJson(item))),
        wind: Wind.fromJson(json['wind']));
  }
}
