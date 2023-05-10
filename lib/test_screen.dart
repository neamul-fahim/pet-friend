


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  class TestScreen extends StatefulWidget {
    const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var _db=FirebaseFirestore.instance;
  var val=<String,dynamic>{
    "birds" :{
      "name":"parrot",
      "price":530,
      "nature": "wild",}};
  // FirebaseFirestore.instance.collection("products")
  //    .doc("pets")
  //    .collection("birds")
  //    .doc()
  //    .set(val,SetOptions(merge: true));

  var birds;
  void fun () async{
   birds=await _db.collection("products")
        .doc("pets")
        .collection("birds")
        .get();
   //      if await is not used
   //       .then(( value) {
   //         print("then..........................................");
   //    print(value.size);
   //    print(value.docs[0].id);
   //
   //         setState(() {});
   //         print("then..........................................");
   //      return Future.value();
   // },
   //    onError: (e) => print("Error getting document: $e"),
   //
   //  );
         print("value=========${birds.size}");

   setState(() {
   });
  }

  @override
  void initState() {
    fun();
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // TODO: implement initState
    super.initState();
  }

    @override
    Widget build(BuildContext context) {

    print("build method.................................");
      //fun();
      //print("value=========${birds.size}");
      //print("value=========${birds.docs[0].data()}");


      return Container(
        color: Colors.white,
        child: birds==null?
            Center(child: CircularProgressIndicator()):
        Text("size---${birds.size}  id---${birds.docs[0].id}  data---${birds.docs[0].data()["birds"]["price"]}")
      );

    }
}
