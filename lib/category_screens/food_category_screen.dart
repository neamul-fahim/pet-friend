

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


  @override
  Widget build(BuildContext context) {

    final food=Provider.of<FoodProvider>(context);
    final filterPets=Provider.of<FilterProvider>(context);


    //final filterPets=Provider.of<FilterProvider>(context);

    Future<void>getData()async {
      await food.initializeFoodList();
      setState(() {
        once=false;
        loadedData=true;
      });
    }
    if (once) getData();

    List <dynamic> foodList=[];

    void fun(){
      var t=food.foodList;
      for(int i=0;i<t.length;i++) {
        if(!filterPets.filterData["birds"] && t[i].key=="bird") foodList.add(t[i]);
        if(!filterPets.filterData["cats"] && t[i].key=="cat") foodList.add(t[i]);
        if(!filterPets.filterData["dogs"] && t[i].key=="dog") foodList.add(t[i]);
      }
    }

    fun();



    // List<> accessoryList=cats.catList+birds.birdList+dogs.dogList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('All food'),
        actions:  [
          IconButton(
            //alignment: Alignment.centerRight,
              color: Colors.white,///this color only acts when onPressed in fully implemented
              iconSize: 40,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return FilterScreen();
                }));
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
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context,item){
            return GridItem(pets: foodList[item],);///Image.asset(accessoryList[item].imgUrl);
          }),
    );
  }
}
