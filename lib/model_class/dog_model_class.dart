

import 'package:cloud_firestore/cloud_firestore.dart';

class DogModelClass{
  String? category;
  String? key;
  String?  id;
  final String?  breed;
  final List<String>?  colors;
  final String? trained;
  final String?  age;
  final double?  price;
  List<String>? imgURL;

  DogModelClass({this.category,this.key='dog',this.id, this.breed, this.colors,this.trained, this.age,this.price,this.imgURL});


  factory DogModelClass.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snap){
    final id=snap.id;
    final data=snap.data();
    return DogModelClass(
      category: data?["category"],
      key: data?["key"],
      id: data?["id"], //id
      breed: data?["breed"],
      colors: data?["colors"] is Iterable ? List.from(data?['colors']) : null,
      trained: data?["trained"],
      age: data?["age"],
      price: data?["price"],
      imgURL: data?["imgURL"]is Iterable ? List.from(data?['imgURL']) : null,
    );
  }


  Map<String,dynamic> toFirebase(){
    return {
      if(category!=null) "category":category,
      if(key!=null) "key":key,
      if(id!=null) "id":id,
      if(breed!=null) "breed":breed,
      if(colors!=null) "colors":colors,
      if(trained!=null) "trained":trained,
      if(age!=null) "age":age,
      if(price!=null) "price":price,
      if(imgURL!=null) "imgURL":imgURL,
    };
  }




}

  class DogRepository{

   List<DogModelClass> _dogs= [
  DogModelClass(breed: 'golden retriever' , colors: ['white','brown'], trained: 'trained',age: '1 year',price: 100,imgURL: ['assets/dog_pics/golden retriever.jpg']),
  DogModelClass(breed: 'labrador' , colors: ['white','brown'], trained: 'not trained',age: '5 years', price: 100,imgURL: ['assets/dog_pics/labrador.jpg']),
  DogModelClass(breed: 'siberian huskey' ,colors:  ['white','black'],trained: 'trained',age:  '5 months',price:  100,imgURL: ['assets/dog_pics/siberian huskey.jpeg']),
  DogModelClass(breed: 'german shepherd' ,colors:  ['brown','black'],trained: 'not trained',age:  '3 years',price:  100,imgURL: ['assets/dog_pics/german shepherd.jpg']),
  DogModelClass(breed: 'bull dog' , colors: ['white','black','brown'],trained: 'trained', age: '2 years', price: 100,imgURL: ['assets/dog_pics/bull dog.jpg']),
    ];


  final _db=FirebaseFirestore.instance;

  Future<List<DogModelClass>> getFireData() async{
    List<DogModelClass> snap=[];
    try {
      final tempJson = await _db.collection("products").doc("pets").collection(
          "dog").get();
      for (int i=0;i<tempJson.docs.length;i++) {
        snap.add(DogModelClass.fromFirestore(tempJson.docs[i]));
      }
    }catch(e){
      print("*********************************************ERROR***************************************");
      print(e.toString());
    }
    _dogs +=snap;
    return [..._dogs];
  }



}