


 import 'package:cloud_firestore/cloud_firestore.dart';

class AccessoryModelClass{
  String ? id;
  String ? name;
  String? firebasePath;
  String?description;
  String ? category;  ///accessories
  String? key; ///cat,dog,bird etc
  double ? price;
  List<dynamic>? imgURL;

  AccessoryModelClass({this.id, this.name,this.firebasePath,this.description,this.category,this.key="accessory",this.price,this.imgURL});

  factory AccessoryModelClass.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snap){

   final id=snap.id;
   final data=snap.data();
   print("${id}fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
   return
    AccessoryModelClass(
     id: id,
     name:data?["name"],
     firebasePath: data?["firebasePath"],
     description: data?["description"],
     category: data?["category"],
     key: data?["key"],
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
     if(price != null) "price": price,
     if(imgURL != null) "imgURL": imgURL,
   };
  }
}


 class AccessoryRepository {
   final _db=FirebaseFirestore.instance;

   List<AccessoryModelClass> _accessory=[];

   Future<List<AccessoryModelClass>> getFireData() async{
     List<AccessoryModelClass> snap=[];
     try {
       final tempJson = await _db.collection("products").doc("accessory").collection(
           "allTypes").get();

       print(" accessory AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA${tempJson.docs.length}AAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
       for (int i=0;i<tempJson.docs.length;i++) {
         var t=AccessoryModelClass.fromFirestore(tempJson.docs[i]);
         snap.add(t);
       }
     }catch(e){
       print("*********************************************ERROR***************************************");
       print(e.toString());
     }
     _accessory +=snap;
     return [..._accessory];
   }
 }