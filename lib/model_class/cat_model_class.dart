
import 'package:cloud_firestore/cloud_firestore.dart';

class CatModelClass{
  String? category;
  String? key;
  String? id;
  String? firebasePath;
  final String? breed;
  final List<String>? colors;
  final String? trained;
  final String? age;
  final double?  price;
  List<String>? imgURL;

  CatModelClass({this.category,this.key="cat",this.id,this.firebasePath, this.breed, this.colors, this.trained,this.age,this.price,this.imgURL});


     factory CatModelClass.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snap){
         final id=snap.id;
         final data=snap.data();
       return CatModelClass(
         category: data?["category"],
         key: data?["key"],
         id: data?["id"], //id
         firebasePath: data?["firebasePath"],
         breed: data?["breed"],
         colors: data?["colors"] is Iterable ? List.from(data?['colors']) : null,
         trained: data?["trained"],
         age: data?["age"],
         price: data?["price"],
         imgURL: data?["imgURL"] is Iterable ? List.from(data?['imgURL']) : null,
       );
     }


  Map<String,dynamic> toFirebase() {
    return {
      if(category != null) "category":category,
      if(key != null) "key": key,
      if(id != null) "id": id,
      if(firebasePath!=null) "firebasePath":firebasePath,
      if(breed != null) "breed": breed,
      if(colors != null) "colors": colors,
      if(trained != null) "trained": trained,
      if(age != null) "age": age,
      if(price != null) "price": price,
      if(imgURL != null) "imgURL": imgURL,
    };
  }

}

  class CatRepository{
    List<CatModelClass> _cats= [
   CatModelClass( breed: 'ragdoll',colors: ['white','black'] , trained:  'trained',age: '2 years 5 months',price: 100,imgURL: ['assets/cat_pics/ragdoll.jpg']),
   CatModelClass( breed: 'british shorthair',colors: ['ash'] , trained:  'not trained',age: '2 years',price:  100,imgURL:['assets/cat_pics/british shorthair.jpeg']),
   CatModelClass(breed: 'maine coon',colors: ['brown','black'] , trained: 'trained', age: '1 year',price: 100,imgURL: ['assets/cat_pics/maine coon.jpeg']),
   CatModelClass(breed:  'persian',colors: ['brown','white'] , trained: 'not trained', age: '7 months',price: 100,imgURL: ['assets/cat_pics/persian.jpeg']),
   CatModelClass( breed: 'siamese',colors: ['white','black'] , trained:  'trained',age: '1 year',price: 100,imgURL: ['assets/cat_pics/siamese.jpeg']),
  ];

      final _db=FirebaseFirestore.instance;

     Future<List<CatModelClass>> getFireData() async{
     List<CatModelClass> snap=[];
         try {
            final tempJson = await _db.collection("products").doc("pets").collection(
           "cat").get();
            for (int i=0;i<tempJson.docs.length;i++) {
               snap.add(CatModelClass.fromFirestore(tempJson.docs[i]));
                }
              }catch(e){
                   print("*********************************************ERROR***************************************");
                  print(e.toString());
                  }
                 _cats +=snap;
                     return [..._cats];
                   }

          }