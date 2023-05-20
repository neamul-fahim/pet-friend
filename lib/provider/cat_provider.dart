



import 'package:flutter/material.dart';

import '../model_class/cat_model_class.dart';

class CatProvider with ChangeNotifier{
    /// final CatRepository _catRepo=CatRepository();
     List<CatModelClass> _catList=[];
     List<CatModelClass> get catList{
       return [..._catList];
      }

       Future<void>initializeCatList ()async{
       _catList=await CatRepository().getFireData();
      // notifyListeners();
      }
  }