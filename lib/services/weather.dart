import 'package:climate/services/location_data.dart';
import 'package:climate/services/networking.dart';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=apiKey&units=metric';
    NetworkHelper helper = NetworkHelper(url);
    var weatherData = await helper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    GetLocation location = GetLocation();
    await location.getCurrentLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;
    NetworkHelper helper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=426642b5653313943d61f10a407f9ee8&units=metric');
    var weatherdata = await helper.getData();
    return weatherdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    print(temp);
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
