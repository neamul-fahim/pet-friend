

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartModelClass{

  String? firebasePath;
  int? productQuantity;

  CartModelClass({this.firebasePath, this.productQuantity});

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


     final _db=FirebaseFirestore.instance;
     final uid=FirebaseAuth.instance.currentUser?.uid;

      setCartDataToFirebase(dynamic item ,BuildContext context)async{
        var cartData=await _db.collection("users").doc(uid).collection("cart").doc(item.id).get();
        int quantity=1;
        if(cartData.exists) {
           quantity = cartData["productQuantity"];
          quantity++;
        }
        print("***************************************************${item.firebasePath}************************");
          var fireData=CartModelClass(firebasePath: item.firebasePath,productQuantity:quantity);
          await _db.collection("users").doc(uid).collection("cart").doc(item.id).set(fireData.toFirebase())
              .then((response){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("item added to cart"))));
          }).catchError((e){
            print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${e.toString()}eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          });


     }


     GetAndSetCartDataToFirebase();
}