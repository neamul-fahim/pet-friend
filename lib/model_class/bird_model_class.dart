

import 'package:cloud_firestore/cloud_firestore.dart';

class BirdModelClass {
   String? category;
   String? key ;
   String? id;
   String? firebasePath;
  final String? name;
  final List<String>? colors;
  final String? talk;
  final String? fly;
  final String? age;
  final double? price;
   List<dynamic>? imgURL;

  BirdModelClass({this.category,this.key="bird",this.id, this.firebasePath,this.name, this.colors, this.talk, this.fly, this.age, this.price,this.imgURL});


    factory BirdModelClass.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snap){

       final id=snap.id;
       final data=snap.data();
      print("${id}fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
      return
        BirdModelClass(
          category: data?["category"],
          id: id,
          key: data?["key"],
          firebasePath: data?["firebasePath"],
          price: data?["price"],
        age: data?["age"],
        fly: data?["fly"],
        talk: data?["talk"],
          name: data?["name"],
         colors: data?["colors"]is Iterable ? List.from(data?['colors']) : null,
        imgURL: data?["imgURL"],
          ///colors and imgURL both are ok
      );
    }


  Map<String, dynamic> toFirebase() {
    return {
      if(category!=null) "category":category,
      if(key!=null) "key":key,
      if(id != null) "id": id,
      if(firebasePath!=null) "firebasePath":firebasePath,
      if(name != null) "name": name,
      if(colors != null) "colors": colors,
      if(talk != null) "talk": talk,
      if(fly != null) "fly": fly,
      if(age != null) "age": age,
      if(price != null) "price": price,
      if(imgURL != null) "imgURL": imgURL,
    };
  }
}




  class BirdRepository {
  final _db=FirebaseFirestore.instance;

   List<BirdModelClass> _birds=[];
  //  = [
  //   BirdModelClass( key: "bird", name: 'budgerigar',colors:  ['blue', 'white', 'black'], talk: "can't talk",fly: 'can fly',age: '9 months', price: 75,imgURL: ['assets/bird_pics/budgerigar.jpg']),
  //   BirdModelClass( key: "bird",name: 'parrot', colors: ['yellow', 'green', 'blue', 'white', 'red'],talk: "can talk",fly: 'can fly',age: '6 months',price:  75,imgURL: ['assets/bird_pics/parrot.jpg']),
  //   BirdModelClass( key: "bird",name: 'owl', colors: ['brown', 'white'],talk: "can't talk", fly: "can't fly",age: '1 year 2 months',price:  75,imgURL: ['assets/bird_pics/owl.jpg']),
  //   BirdModelClass( key: "bird",name: 'blue jay',colors:  ['blue', 'white', 'black'],talk:  "can't talk",fly:  "can't fly", age: '1 year', price: 75,imgURL: ['assets/bird_pics/blue jay.jpg']),
  //   BirdModelClass( key: "bird",name: 'falcon',colors:  ['brown', 'black'],talk: "can't talk",fly:  'can fly',age: '2 years', price: 75,imgURL: ['assets/bird_pics/falcon.jpg']),
  // ];

  Future<List<BirdModelClass>> getFireData() async{
    List<BirdModelClass> snap=[];
    try {
      final tempJson = await _db.collection("products").doc("pets").collection(
          "bird").get();
        for (int i=0;i<tempJson.docs.length;i++) {
           var t=BirdModelClass.fromFirestore(tempJson.docs[i]);
           snap.add(t);
        }
    }catch(e){
      print("*********************************************ERROR***************************************");
      print(e.toString());
    }
    _birds +=snap;
      return [..._birds];
  }
}