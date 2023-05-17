

import 'package:flutter/material.dart';
import 'package:pet_friend/pets_category_screen/pets_grid_item.dart';
import 'package:provider/provider.dart';

import '../filter_screen/filter_screen.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/filter_provider.dart';

class PetsCategoryScreen extends StatelessWidget {
  const PetsCategoryScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

     final cats=Provider.of<CatProvider>(context); cats.initializeCatList();

     final birds=Provider.of<BirdProvider>(context); birds.initializeBirdList();

     final dogs=Provider.of<DogProvider>(context); dogs.initializeDogList();

     final filterPets=Provider.of<FilterProvider>(context);

     // Future<void>getData()async {
     //   cats.initializeCatList();
     //   await birds.initializeBirdList();
     //   dogs.initializeDogList();
     // }
     // getData();


     print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
     print(birds.birdList.length);

     /// List <dynamic> pets=[...cats.catList,...birds.birdList,...dogs.dogList]; /// this also works instead of the mixInPetsList function but it doesn't mix the list items
     List <dynamic> pets=[];

      /// mixes the different pets list and stores in List <dynamic> pets SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
     void mixInPetsList(){
       int dogsSize=dogs.dogList.length;
       int birdsSize=birds.birdList.length;
       if(birdsSize==0){
         print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
       }
       int catsSize=cats.catList.length;
       int totalC=dogsSize+birdsSize+catsSize;
       int birdsC=0; int catsC=0; int dogsC=0;
       if(filterPets.filterData["birds"]) totalC-=birdsSize;

       for(int i=0;i<=totalC;i++){
         if(!filterPets.filterData["birds"])
        if(birdsC<birdsSize){
          pets.add(birds.birdList[birdsC]);
          birdsC++;
        }
        if(catsC<catsSize){
          pets.add(cats.catList[catsC]);
          catsC++;
        }
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
      body: birds.birdList.length<6?Center(child: CircularProgressIndicator()):
      GridView.builder(
          itemCount: pets.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2/3.09,
            crossAxisCount: 3,
              //crossAxisSpacing: 1,
           // mainAxisSpacing: 1,
          ),
          itemBuilder: (context,item){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PetsCategoryGridItem(pets: pets[item],),
            );///Image.asset(pets[item].imgUrl);
          }),
    );
  }
}
