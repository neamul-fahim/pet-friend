

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataModel {
  String? uid;
  String ? name;
  String ? phone;
  String ? email;
  String ? address;
  String ? profilePicURL;



  UserDataModel({this.uid, this.name, this.phone, this.email,this.address,this.profilePicURL});

  ///set method
  Map<String , dynamic > toMap(){
    return{
      "uid":uid,
      "name":name,
      "phone":phone,
       "email":email,
       "address":address,
        "profilePicURL":profilePicURL,
    };
  }

  ///get method
  factory UserDataModel.fromMap(map){
    return UserDataModel(
         uid: map?["uid"],
         name: map?["name"],
         phone: map?["phone"],
         email: map?["email"],
         address: map?["address"],
         profilePicURL: map?["profilePicURL"],
    );
  }

  // Map<String,dynamic> CartFromFirestore(DocumentSnapshot<Map<String,dynamic>> snap){
  //
  //   final id=snap.id;
  //   final data=snap.data();
  //   return
  //     {
  //       "productId":id,
  //       "productQuantity":data?["productQuantity"],
  //     };
  // }

}


class UserDataRepository {
  final _db=FirebaseFirestore.instance;
  var user=FirebaseAuth.instance.currentUser?.uid;

  var _userData;

  Future<dynamic> getFireData() async{
    try {

      final tempJson = await _db.collection("users").doc(user).get();
        _userData=UserDataModel.fromMap(tempJson.data());
        print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE${_userData.uid} ${_userData.profilePicURL}EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");

    }catch(e){
      print("*********************************************ERROR***************************************");
      print(e.toString());
    }
    return _userData;

  }

  Future<dynamic> getCartFireData(String proId) async{
    var quantity;
    try {
      final tempJson = await _db.collection("users").doc(user).collection("cart").doc(proId).get();

      var t=tempJson.data();
            quantity=t==null?1:t["productQuantity"];

    }catch(e){
      print("*********************************************ERROR***************************************");
      print(e.toString());
    }

    return quantity;
  }

}