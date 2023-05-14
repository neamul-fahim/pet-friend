

  import 'package:flutter/cupertino.dart';


  class FilterProvider with ChangeNotifier {
   final Map<String,bool> _filterData={  //List<dynamic>
     "birds":false,//["Birds",false],
     "cats":false,//["Cats",false],
     "dogs":false,//["Dogs",false],
   };

    Map get filterData{
      return _filterData;
    }

  void filterBirds(bool switchVal){
    _filterData["birds"]=switchVal;
    notifyListeners();
  }
}