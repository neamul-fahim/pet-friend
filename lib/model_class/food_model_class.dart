

import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModelClass{

  String ? id;
  String ? name;
  String? firebasePath;
  String?description;
  String ? category;
  String? key; ///cat,dog,bird etc
  String ? quantity;
  double ? price;
  List<dynamic>? imgURL;

  FoodModelClass(
      {this.id,
      this.name,
      this.firebasePath,
      this.description,
      this.category,
      this.key,
        this.quantity,
        this.price,
      this.imgURL});

  factory FoodModelClass.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snap){
    final id=snap.id;
    final data=snap.data();
    //print("${id}fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    return
      FoodModelClass(
        id: id,
        name:data?["name"],
        firebasePath: data?["firebasePath"],
        description: data?["description"],
        category: data?["category"],
        key: data?["key"],
        quantity: data?["quantity"],
        price: data?["price"],
        imgURL: data?["imgURL"],
      );
  }


  Map<String, dynamic> toFirebase() {
    return {
      if(id != null) "id": id,
      if(name != null) "name": name,
      if(firebasePath != null) "firebasePath":firebasePath,
      if(description != null) "description": description,
      if(category!=null) "category":category,
      if(key!=null) "key":key,
      if(quantity!=null) "quantity":quantity,
      if(price != null) "price": price,
      if(imgURL != null) "imgURL": imgURL,
    };
  }

}


class FoodRepository {
  final _db=FirebaseFirestore.instance;

  List<FoodModelClass> _food=[];

  Future<List<FoodModelClass>> getFireData() async{
    List<FoodModelClass> snap=[];
    try {
      final tempJson = await _db.collection("products").doc("food").collection(
          "allTypes").get();

      print(" accessory AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA${tempJson.docs.length}AAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      for (int i=0;i<tempJson.docs.length;i++) {
        var t=FoodModelClass.fromFirestore(tempJson.docs[i]);
        snap.add(t);
      }
    }catch(e){
      print("*********************************************ERROR***************************************");
      print(e.toString());
    }
    _food +=snap;
    return [..._food];
  }
}