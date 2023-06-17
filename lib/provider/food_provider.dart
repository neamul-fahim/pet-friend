



import 'package:flutter/material.dart';

import '../model_class/accessory_model_class.dart';
import '../model_class/bird_model_class.dart';
import '../model_class/food_model_class.dart';

class FoodProvider with ChangeNotifier{
  /// final BirdRepository _birdRepo= BirdRepository();
  List<FoodModelClass> _foodList=[];

  List<FoodModelClass> get foodList{
    return [..._foodList];
  }

  Future<void> initializeFoodList()async {
    _foodList=await FoodRepository().getFireData();
    //notifyListeners();
  }


}