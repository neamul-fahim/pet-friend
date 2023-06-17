

import 'package:flutter/material.dart';
import 'package:pet_friend/category_screens/grid_item.dart';
import 'package:provider/provider.dart';
import '../filter_screen/filter_screen.dart';
import '../provider/accessory_provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/filter_provider.dart';

class AccessoryCategoryScreen extends StatefulWidget {

  AccessoryCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AccessoryCategoryScreen> createState() => _AccessoryCategoryScreenState();
}

class _AccessoryCategoryScreenState extends State<AccessoryCategoryScreen> {
  bool once=true; bool loadedData=false;
  List <dynamic> accessoryList=[];


  @override
  Widget build(BuildContext context) {

    final accessory=Provider.of<AccessoryProvider>(context);

    //final filterPets=Provider.of<FilterProvider>(context);

    Future<void>getData()async {
      await accessory.initializeAccessoryList();
      accessoryList=accessory.accessoryList;
      setState(() {
        once=false;
        loadedData=true;
      });
    }
    if (once) getData();



    // List<> accessoryList=cats.catList+birds.birdList+dogs.dogList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All accessory'),
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
      body: !loadedData && accessoryList.isEmpty?const Center(child: CircularProgressIndicator())
          :
          loadedData && accessoryList.isEmpty?const Center(child: Text("Empty",style: TextStyle(fontSize: 25,color: Colors.black38),))
          :
      GridView.builder(
          itemCount: accessoryList.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2/3.09,
            crossAxisCount: 3,
            //crossAxisSpacing: 1,
            // mainAxisSpacing: 1,
          ),
          itemBuilder: (context,item){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridItem(pets: accessoryList[item],),
            );///Image.asset(accessoryList[item].imgUrl);
          }),
    );
  }
}
