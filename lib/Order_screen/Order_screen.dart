import 'package:flutter/material.dart';

import '../category_screens/pets_category_screen.dart';
import '../payment_gateway.dart';

class OrderScreen extends StatelessWidget {
  final String customerName;
  final String email;
  final String phoneNumber;
  final String address;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  OrderScreen({
    required this.customerName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Card(
        margin: EdgeInsets.only(top: 50),
        elevation: 100,
        shadowColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Details
            ListTile(
              title: Text('Customer Details', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $customerName',style: TextStyle(color: Colors.black)),
                  Text('Email: $email',style: TextStyle(color: Colors.black)),
                  Text('Phone Number: $phoneNumber',style: TextStyle(color: Colors.black)),
                  Text('Address: $address',style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            Divider(),

            // Product Details
            ListTile(
              title: Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Picture
                  Image.asset('assets/car_pics/car1.jpg'),

                  // Product Name, Quantity, Price, and Total Price
                  Text('Name: $productName',style: TextStyle(color: Colors.black)),
                  Text('Quantity: $quantity',style: TextStyle(color: Colors.black)),
                  Text('Price (per unit): \$${unitPrice.toStringAsFixed(2)}',style: TextStyle(color: Colors.black)),
                  Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',style: TextStyle(color: Colors.black),),
                ],
              ),
            ),

            Center(
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  onPressed:(){
                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return PaymentGateway();
                              }));
                         },

                  child:Text("Place order",style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
