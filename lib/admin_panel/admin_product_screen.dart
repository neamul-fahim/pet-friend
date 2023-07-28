

import 'package:flutter/material.dart';
import 'package:pet_friend/admin_panel/admin_product_grid_item.dart';
import 'package:pet_friend/provider/food_provider.dart';
import 'package:provider/provider.dart';
import '../filter_screen/filter_screen.dart';
import '../provider/accessory_provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/filter_provider.dart';

class AdminProductScreen extends StatefulWidget {
  final category;


  AdminProductScreen(
  {Key? key,
  required this.category,
  }) : super(key: key);







  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  bool once=true; bool loadedData=false;
  bool _isMounted = false;


  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }


  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {

    final cats=Provider.of<CatProvider>(context);
    final birds=Provider.of<BirdProvider>(context);
    final dogs=Provider.of<DogProvider>(context);
    final food=Provider.of<FoodProvider>(context);
    final accessory=Provider.of<AccessoryProvider>(context);
    final filterPets=Provider.of<FilterProvider>(context);

    Future<void>getData()async {
      await cats.initializeCatList();
      await birds.initializeBirdList();
      await dogs.initializeDogList();
      await food.initializeFoodList();
      await accessory.initializeAccessoryList();


      if (_isMounted) {
        setState(() {
        once=false;
        loadedData=true;
      });
      }
    }
    if (once) getData();


    //print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // print(birds.birdList.length);

    /// List <dynamic> products=[...cats.catList,...birds.birdList,...dogs.dogList]; /// this also works instead of the mixInPetsList function but it doesn't mix the list items
    List <dynamic> products=[];


    if(widget.category=="pets"){
      products=[...birds.birdList,...dogs.dogList,...cats.catList];
    }
    if(widget.category=="food"){
      products=[...food.foodList];
    }
    if(widget.category=="accessory"){
      products=[...accessory.accessoryList];
    }



    // List<> products=cats.catList+birds.birdList+dogs.dogList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("${widget.category}"),

      ),
      body: !loadedData && products.isEmpty?const Center(child: CircularProgressIndicator())
          :
      loadedData && products.isEmpty?const Center(child: Text("Empty",style: TextStyle(fontSize: 25,color: Colors.black38),))
          :
      GridView.builder(
          itemCount: products.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2/3.09,
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context,item){
            return AdminProductGridItem(products: products[item],);///Image.asset(products[item].imgUrl);
          }),
    );
  }
}
