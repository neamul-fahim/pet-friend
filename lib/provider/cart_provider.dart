


 import 'package:flutter/cupertino.dart';

 class CartProvider with ChangeNotifier{

  final List<dynamic> _cartData=[];

  List<dynamic> get cartData{
    return [..._cartData];
  }

  void addToCart(dynamic item) {
    _cartData.add(item);
    notifyListeners();
  }

  }