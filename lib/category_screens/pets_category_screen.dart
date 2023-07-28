

import 'package:flutter/material.dart';
import 'package:pet_friend/category_screens/grid_item.dart';
import 'package:provider/provider.dart';
import '../filter_screen/filter_screen.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/filter_provider.dart';

class PetsCategoryScreen extends StatefulWidget {

  PetsCategoryScreen({Key? key}) : super(key: key);

  @override
  State<PetsCategoryScreen> createState() => _PetsCategoryScreenState();
}

class _PetsCategoryScreenState extends State<PetsCategoryScreen> {
  bool once=true; bool loadedData=false;


  @override
  Widget build(BuildContext context) {

     final cats=Provider.of<CatProvider>(context);
     final birds=Provider.of<BirdProvider>(context);
     final dogs=Provider.of<DogProvider>(context);
     final filterPets=Provider.of<FilterProvider>(context);

     Future<void>getData()async {
      await cats.initializeCatList();
       await birds.initializeBirdList();
      await dogs.initializeDogList();

      setState(() {
        once=false;
        loadedData=true;
      });
     }
    if (once) getData();


     //print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // print(birds.birdList.length);

     /// List <dynamic> pets=[...cats.catList,...birds.birdList,...dogs.dogList]; /// this also works instead of the mixInPetsList function but it doesn't mix the list items
     List <dynamic> pets=[];

      /// mixes the different pets list and stores in List <dynamic> pets SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
     void mixInPetsList(){
       int dogsSize=dogs.dogList.length;
       int birdsSize=birds.birdList.length;
       if(birdsSize==0){
         //print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
       }
       int catsSize=cats.catList.length;
       int totalC=dogsSize+birdsSize+catsSize;
       int birdsC=0; int catsC=0; int dogsC=0;
       if(filterPets.filterData["birds"]) totalC-=birdsSize;
       if(filterPets.filterData["dogs"]) totalC-=dogsSize;
       if(filterPets.filterData["cats"]) totalC-=catsSize;

       for(int i=0;i<=totalC;i++){
         if(!filterPets.filterData["birds"])
        if(birdsC<birdsSize){
          pets.add(birds.birdList[birdsC]);
          birdsC++;
        }

         if(!filterPets.filterData["cats"])
           if(catsC<catsSize){
          pets.add(cats.catList[catsC]);
          catsC++;
        }

         if(!filterPets.filterData["dogs"])
           if(dogsC<dogsSize){
          pets.add(dogs.dogList[dogsC]);
          dogsC++;
        }
        if(birdsC==birdsSize && catsC==catsSize && dogsC==dogsSize)  break;
       }
     }
     mixInPetsList();
     /// mixes the different pets list and stores in List <dynamic> pets EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


     // List<> pets=cats.catList+birds.birdList+dogs.dogList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('All Pets'),
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
      body: !loadedData && pets.isEmpty?const Center(child: CircularProgressIndicator())
          :
           loadedData && pets.isEmpty?const Center(child: Text("Empty",style: TextStyle(fontSize: 25,color: Colors.black38),))
          :
      GridView.builder(
          itemCount: pets.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2/3.09,
            crossAxisCount: 3,
              crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context,item){
            return GridItem(pets: pets[item],);///Image.asset(pets[item].imgUrl);
          }),
    );
  }
}
