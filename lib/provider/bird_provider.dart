



import 'package:flutter/material.dart';

import '../model_class/bird_model_class.dart';

class BirdProvider with ChangeNotifier{
  /// final BirdRepository _birdRepo= BirdRepository();
   List<BirdModelClass> _birdList=[];

   List<BirdModelClass> get birdList{
     return [..._birdList];
   }

   Future<void> initializeBirdList()async {
     _birdList=await BirdRepository().getFireData();
    // notifyListeners();
   }


}