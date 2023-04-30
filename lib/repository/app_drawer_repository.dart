




import 'dart:convert';

import '../model_class/app_drawer_model_class.dart';
import '../utills/all_strings.dart';
import 'package:http/http.dart' as http;


class AppDrawerRepository{

  AppDrawerModelClass appDrawerModelClass=AppDrawerModelClass(

    profilePic: 'assets/image/profie_pic.jpg',
      profileName: 'Name',
  );
}
 class WeatherRepository{

   AllStrings allStrings=AllStrings();
   WeatherModelClass weatherModelClass=WeatherModelClass();

   Future<WeatherModelClass>WeatherDataApi(String city) async{
       var url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city &appid=${allStrings.apiKey}');
      http.Response response= await http.get(url);

  if(response.statusCode==200)
    {
      weatherModelClass=WeatherModelClass.fromJson(jsonDecode(response.body));
      return weatherModelClass;
    }
  else{
    throw Exception('Data not found');
  }
 }
 }