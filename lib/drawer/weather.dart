



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_drawer_provider.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

   List<String>cityName=['dhaka','sylhet','barisal','mymensingh','rangpur','rajshahi','chittagong'];
  String selectedValue=cityName[0];
class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {

    Provider.of<WeatherProvider>(context,listen: false).initializeWeatherModelClass(selectedValue);
    double dynamicHeight =MediaQuery.of(context).size.height;
    double dynamicWidth =MediaQuery.of(context).size.width;



    return Scaffold(
      appBar: AppBar(),
      body: Consumer<WeatherProvider>(builder: (context,weatherProvider,index){
        return  Container(
          height: dynamicHeight,
          width: dynamicWidth,
          color: Colors.blue.shade300,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: DropdownButton(
                     // alignment: Alignment.center,
                      style: TextStyle(
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(30),

                      //iconDisabledColor: Colors.orange,
                      dropdownColor: Colors.deepOrangeAccent,
                      iconEnabledColor: Colors.deepOrangeAccent,
                      focusColor: Colors.deepOrangeAccent,
                    value: selectedValue,
                      items: cityName.map((index){
                    return DropdownMenuItem<String>(
                        value: index,
                        child: Text(index));
                  }).toList(),

                      onChanged: (newValue){
                    setState(() {
                      selectedValue=newValue.toString();

                    });
                      }),
                ),
                 weatherProvider.weatherModelClass.visibility==0?

            CircularProgressIndicator(): apidata(weatherProvider)


              ],
            ),
          ),
        );
      }),
    );

  }
}
 Widget apidata(WeatherProvider weatherProvider){
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        Text('Place -> ' +
            weatherProvider.weatherModelClass.sys!.country.toString()),
        Text('Place -> ' +
            weatherProvider.weatherModelClass.name.toString()),
        Text('weather -> ' +
            weatherProvider.weatherModelClass.weather![0].main
                .toString()),

        Text('feelsLike -> ' +
            weatherProvider.weatherModelClass.main!.feelsLike
                .toString()),
        Text('humidity -> ' +
            weatherProvider.weatherModelClass.main!.humidity
                .toString()),
        Text('pressure -> ' +
            weatherProvider.weatherModelClass.main!.pressure
                .toString()),
        Text('temp -> ' +
            weatherProvider.weatherModelClass.main!.temp.toString()),
        Text('tempMax -> ' +
            weatherProvider.weatherModelClass.main!.tempMax.toString()),
        Text('tempMin -> ' +
            weatherProvider.weatherModelClass.main!.tempMin.toString()),
        Text('Wind Speed -> ' +
            weatherProvider.weatherModelClass.wind!.speed.toString()),
        SizedBox(
          height: 80,
        ),
        Text('Wind Speed -> ' +
            weatherProvider.weatherModelClass.toString()),
      ],
    ),
  );


 }