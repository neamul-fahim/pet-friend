



import 'package:flutter/material.dart';

import '../model_class/accessory_model_class.dart';
import '../model_class/bird_model_class.dart';

class AccessoryProvider with ChangeNotifier{
  /// final BirdRepository _birdRepo= BirdRepository();
  List<AccessoryModelClass> _accessoryList=[];

  List<AccessoryModelClass> get accessoryList{
    return [..._accessoryList];
  }

  Future<void> initializeAccessoryList()async {
    _accessoryList=await AccessoryRepository().getFireData();
    //notifyListeners();
  }


}