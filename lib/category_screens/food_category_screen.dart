

import 'package:flutter/material.dart';
import 'package:pet_friend/category_screens/grid_item.dart';
import 'package:provider/provider.dart';
import '../filter_screen/filter_screen.dart';
import '../provider/accessory_provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/filter_provider.dart';
import '../provider/food_provider.dart';

class FoodCategoryScreen extends StatefulWidget {

  FoodCategoryScreen({Key? key}) : super(key: key);

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  bool once=true; bool loadedData=false;
  List <dynamic> foodList=[];


  @override
  Widget build(BuildContext context) {

    final food=Provider.of<FoodProvider>(context);

    //final filterPets=Provider.of<FilterProvider>(context);

    Future<void>getData()async {
      await food.initializeFoodList();
      foodList=food.foodList;
      setState(() {
        once=false;
        loadedData=true;
      });
    }
    if (once) getData();



    // List<> accessoryList=cats.catList+birds.birdList+dogs.dogList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All food'),
        actions:  [
          IconButton(
            //alignment: Alignment.centerRight,
              color: Colors.white,///this color only acts when onPressed in fully implemented
              iconSize: 40,
              onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                //   return FilterScreen();
                // }));
              },
              icon:Icon(Icons.filter_alt,) //Text("save",style: TextStyle(fontSize: 1),)
          ),
        ],
      ),
      body: !loadedData && foodList.isEmpty?const Center(child: CircularProgressIndicator())
          :
      loadedData && foodList.isEmpty?const Center(child: Text("Empty",style: TextStyle(fontSize: 25,color: Colors.black38),))
          :
      GridView.builder(
          itemCount: foodList.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2/3.09,
            crossAxisCount: 3,
            //crossAxisSpacing: 1,
            // mainAxisSpacing: 1,
          ),
          itemBuilder: (context,item){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridItem(pets: foodList[item],),
            );///Image.asset(accessoryList[item].imgUrl);
          }),
    );
  }
}
