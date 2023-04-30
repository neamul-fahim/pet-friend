





import 'package:flutter/material.dart';

import '../model_class/dog_model_class.dart';

class  DogProvider with ChangeNotifier{

  //final DogRepository _dogRepo= DogRepository();
   List<DogModelClass> _dogList=[];
    List<DogModelClass> get dogList{
          return [..._dogList];
       }

       void initializeDogList(){
         _dogList=DogRepository().dogs;
       }
  }