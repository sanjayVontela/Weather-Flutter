import 'package:flutter/material.dart';
import 'package:climate/utilities/constants.dart';
import 'package:climate/services/weather.dart';
import 'package:climate/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key,this.locationWeather});
  final locationWeather;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData == null){
        temperature=0;
        message="Error getting data";
        weatherIcon = "error";
        cityName = "Gotham City";
      }
      double temp = weatherData["main"]["temp"];
      temperature = temp.toInt();
      message = model.getMessage(temperature ?? 0);
      var condition = weatherData["weather"][0]["id"];
      weatherIcon = model.getWeatherIcon(condition);
      cityName = weatherData["name"];
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/location_background.jpg'),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () async{
                    var weatherdata = await model.getLocationWeather();
                    updateUI(weatherdata);
                  }, child: Icon(Icons.near_me,size: 50,),),
                  TextButton(onPressed: () async {
                    var name = await Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CityScreen();

                    }));
                    if(name != null){
                      var weatherData = await model.getCityWeather(name);
                      updateUI(weatherData);
                    }
                    }, child: Icon(Icons.location_city,size: 50,))
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 15),child: Row(
                children: [
                  Text("$temperature",style: kTempTextStyle,),
                  Text(
                    '$weatherIcon',
                    style: kConditionTextStyle,
                  )
                ],
              ),),
              Padding(padding: EdgeInsets.only(right: 15),
              child: Text( "$message in $cityName!",style: kMessageTextStyle,textAlign: TextAlign.right,),)
            ],
          ),
        ),
      ),
    );
  }
}

