

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



class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {

     final birds=Provider.of<BirdProvider>(context); birds.initializeBirdList();
     final cats=Provider.of<CatProvider>(context); cats.initializeCatList();
     final dogs=Provider.of<DogProvider>(context); dogs.initializeDogList();

     List<List> petsObject=[birds.birdList];//,cats.catList,dogs.dogList];
     List<String> petImg=[];

     void createList(){
       for(int i=0;i<petsObject.length;i++){
           for(int j=0;j<petsObject[i].length-3;j++){
             var temp=petsObject[i];
             petImg.add(temp[j].imgURL[0]);
             }
         }
     }
      createList();

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
            child: Container(
              decoration: BoxDecoration(border: Border.all(width:0.1, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                //color: Colors.red,
                  image: DecorationImage(
                  image: AssetImage(index),
                    fit: BoxFit.cover,
              )
              ),
            ),
          )
          ).toList(),
        ),


    );
  }
}

