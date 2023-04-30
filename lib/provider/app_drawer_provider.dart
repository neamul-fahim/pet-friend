



import 'package:flutter/material.dart';

import '../model_class/app_drawer_model_class.dart';
import '../repository/app_drawer_repository.dart';

class AppDrawerProvider with ChangeNotifier{

  AppDrawerRepository appDrawerRepository=AppDrawerRepository();
  AppDrawerModelClass _appDrawerModelClass=AppDrawerModelClass();

  AppDrawerModelClass get appDrawerModelClass => _appDrawerModelClass;

  initializeAppDrawerModelClass(){
    _appDrawerModelClass=appDrawerRepository.appDrawerModelClass;
      notifyListeners();
  }
  }

 class  WeatherProvider with ChangeNotifier{

   WeatherRepository weatherRepository=WeatherRepository();
   WeatherModelClass _weatherModelClass=WeatherModelClass();

   WeatherModelClass get weatherModelClass => _weatherModelClass;

   initializeWeatherModelClass(String cityName) async{
     _weatherModelClass=await weatherRepository.WeatherDataApi(cityName);
     notifyListeners();
   }
}