

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartModelClass{

  String? firebasePath;
  int? productQuantity;
  String? imgURL;
  String? id;

  CartModelClass({this.firebasePath, this.productQuantity,this.imgURL,this.id});

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

     Future setCartDataToFirebase(dynamic item ,bool increDecre,BuildContext context)async{
       var path=_db.collection("users").doc(uid).collection("cart").doc(item.id);
        var cartData=await path.get();
        int quantity=1;
        if(cartData.exists) {
           quantity = cartData["productQuantity"];
         if(increDecre) quantity++;
          else if(quantity>1)quantity--;

        }
        print("car_model_class*****************************************${item.firebasePath}************************");
          var fireData=CartModelClass(firebasePath: item.firebasePath,productQuantity:quantity);
          await _db.collection("users").doc(uid).collection("cart").doc(item.id).set(fireData.toFirebase())
              .then((response){
                ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("item added to cart"))));
          }).catchError((e){
            print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${e.toString()}eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          });
     }

     Future DeleteCartItem (dynamic item)async{
       try {
         await _db.collection("users").doc(uid).collection("cart").doc(item.id).delete();
       }catch(e){
         print("car_model_classEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE${e.toString()}EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
       }
    }


}