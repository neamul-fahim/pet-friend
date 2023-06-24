

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartModelClass{
   String? name;
  String? firebasePath;
  int? productQuantity;
  List<dynamic>? imgURL;
  String? id;
  double? price;

  CartModelClass({this.name,this.firebasePath, this.productQuantity,this.imgURL,this.id});

       factory CartModelClass.fromFirestore(Map<String,dynamic> data){

            return CartModelClass(
              firebasePath: data["firebasePath"],
              productQuantity: data["productQuality"],

            );
       }

     Map<String,dynamic> toFirebase(){
       return
           {
             if(firebasePath!=null) "firebasePath":firebasePath,
             if(productQuantity!=null) "productQuantity":productQuantity,
           };
     }

}




  class GetAndSetCartDataToFirebase{///this function will only work with a current user

    GetAndSetCartDataToFirebase();

     final _db=FirebaseFirestore.instance;
     final uid=FirebaseAuth.instance.currentUser?.uid;

     Future <void> setCartDataToFirebase(dynamic item ,bool increDecre,ScaffoldMessengerState scaffoldMessengerState)async{
       var path=_db.collection("users").doc(uid).collection("cart").doc(item.id);

       var cartData=await path.get();///if i press the plus button twice the first press will execute till (var cartData=await path.get();) and will wait for the await call to finish in the meantime the second click will execute and will execute till it's own (var cartData=await path.get();) ***here both the clicks holds the same value at cartData variable*** and now both clicks increments the cartData quantity so both writs the same incremented data on firebase
        int quantity=1;

       if(cartData.exists) {

         quantity = cartData["productQuantity"];
         if(increDecre) {quantity++;} else if(quantity>1) {quantity--;}

        }
        //print("car_model_class*****************************************${item.firebasePath}************************");
          var fireData=CartModelClass(firebasePath: item.firebasePath,productQuantity:quantity);

         await _db.collection("users").doc(uid).collection("cart").doc(item.id).set(fireData.toFirebase());
        scaffoldMessengerState.clearSnackBars();
        if(increDecre) {
          scaffoldMessengerState.showSnackBar(const SnackBar(duration: Duration(seconds: 1),content: Center(child: Text("item added to cart"))));
        } else{
          scaffoldMessengerState.showSnackBar(const SnackBar(duration: Duration(seconds: 1),content: Center(child: Text("item reduced from cart"))));
        }



     }


     Future DeleteCartItem (dynamic item,ScaffoldMessengerState scaffoldMessengerState)async{
       try {
         await _db.collection("users").doc(uid).collection("cart").doc(item.id).delete();
         scaffoldMessengerState.clearSnackBars();
         scaffoldMessengerState.showSnackBar(const SnackBar(duration: Duration(seconds: 1),content: Center(child: Text("Item deleted"))));
       }catch(e){
         print("car_model_classEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE${e.toString()}EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
       }
    }


}