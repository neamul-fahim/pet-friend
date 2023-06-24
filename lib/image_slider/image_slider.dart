

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import 'imaes_of_image_slider.dart';


class ImageSlider extends StatefulWidget {

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

    ImagesOfImageSlider imagesOfImageSlider=ImagesOfImageSlider();


  bool once=true;


  List<String> petImg=[
    'assets/dummy_pic/petsPow.jpg',
    ];


class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {

    var ImageType="asset";
    var temp=petImg[0];
    if(temp[0]=="h" && temp[1]=="t" && temp[2]=="t" && temp[3]=="p") ImageType="network";

     final birds=Provider.of<BirdProvider>(context);
     final cats=Provider.of<CatProvider>(context);
     final dogs=Provider.of<DogProvider>(context);

     Future<void> fun()async {
       await birds.initializeBirdList();
       await cats.initializeCatList();
       await dogs.initializeDogList();

       int len=cats.catList.length+birds.birdList.length+dogs.dogList.length;

       if(len!=0) {
       List<List> petsObject=[cats.catList,birds.birdList,dogs.dogList];
       print("${len}LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");

         petImg = [];
         for (int i = 0; i < petsObject.length; i++) {
           int l=petsObject[i].length;
           for (int j = 0; j < l; j++) { //petsObject[i].length
             var temp = petsObject[i];
             petImg.add(temp[j].imgURL[0]);
           }
         }
         setState(() {
           once=false;
         });
       }
     }

     if(once){
       fun();
     }

        // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        // print(cats.catList.length);
        // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");


    double dynamicHeight =MediaQuery.of(context).size.height;
    double dynamicWidth =MediaQuery.of(context).size.width;



    return Container(
        height:dynamicHeight*0.3,
        width: dynamicWidth,
        decoration: BoxDecoration(
         // color: Colors.teal
        ),
        child: CarouselSlider(

          options: CarouselOptions(

            autoPlayInterval: Duration(seconds: 2),
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            autoPlay: true,
          ),
          items: petImg.map((index)=>PhysicalModel(

            color: Colors.black12,
            shadowColor: Colors.teal,
            elevation: 50,
            borderRadius: BorderRadius.circular(20),
            child: ImageType=="network"?
                  Container(
              decoration: BoxDecoration(border: Border.all(width:0.1, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                //color: Colors.red,
                  image: DecorationImage(
                  image: NetworkImage(index),
                    fit: BoxFit.cover,
              )
              ),
            )
                : Container(
              decoration: BoxDecoration(border: Border.all(width:0.1, color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  //color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage(index),
                    fit: BoxFit.cover,
                  )
              ),
            )

          )
          ).toList(),
        ),


    );
  }
}

