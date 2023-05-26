
import 'package:flutter/material.dart';

 class CartProvider with ChangeNotifier{

    List<List<dynamic>> _cartData=[];

  List<List<dynamic>> get cartData{
    return [..._cartData];
  }

  void addToCart(dynamic item) {
      print("${_cartData.length} LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    bool itemExist=false;
    if (_cartData.isNotEmpty){
      for (int i = 0; i <_cartData.length; i++) {
       // print("${_cartData.length} LLLLLLLLLLLLLLLL 111111111111111111111111111111111111 LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");

        dynamic temp = _cartData[i];
       // print("${temp[0].toFirebase()} DDDD ${temp[1]} DDDD ${item.toFirebase()} DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");

        if (temp[0].imgURL[0] == item.imgURL[0]) {
          itemExist=true;

         // print("${i}   MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
          temp[1]++;
          //notifyListeners();
        }
     }
       }
      if(!itemExist) {
        //print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

        dynamic lst =[item,1];
        _cartData.add(lst);
      }
      notifyListeners();
  }

   void reduceItemCount(dynamic item){
     for (int i = 0; i <_cartData.length; i++) {
       dynamic temp = _cartData[i];
       if (temp[0].imgURL[0] == item.imgURL[0]) {
         temp[1]--;
       }
     }
     notifyListeners();
   }
   void deleteItem(dynamic item){
     for (int i = 0; i <_cartData.length; i++) {
       dynamic temp = _cartData[i];
       if (temp[0].imgURL[0] == item.imgURL[0]) {
         _cartData.removeAt(i);
       }
     }
     notifyListeners();
   }

 }