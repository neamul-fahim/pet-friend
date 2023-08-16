import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final String imgURL;

  OrderScreen({
    required this.customerName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.imgURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Order'),
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Details
            ListTile(
              title: const Text('Customer Details', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $customerName',style: const TextStyle(color: Colors.black,fontSize: 18)),
                  Text('Email: $email',style: const TextStyle(color: Colors.black,fontSize: 18)),
                  Text('Phone Number: $phoneNumber',style: const TextStyle(color: Colors.black,fontSize: 18)),
                  Text('Address: $address',style: const TextStyle(color: Colors.black,fontSize: 18)),
                ],
              ),
            ),
            const Divider(color:Colors.black,thickness: 1),

            // Product Details
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25)),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Picture
                  Image.network(imgURL),

                  // Product Name, Quantity, Price, and Total Price
                  Text('Name: $productName',style: TextStyle(color: Colors.black,fontSize: 18)),
                  Text('Quantity: $quantity',style: TextStyle(color: Colors.black,fontSize: 18)),
                  Text('Price (per unit): ${unitPrice.toStringAsFixed(2)} tk',style: TextStyle(color: Colors.black,fontSize: 18)),
                  Text('Total Price: ${totalPrice.toStringAsFixed(2)} tk',style: TextStyle(color: Colors.black,fontSize: 18),),
                ],
              ),
            ),

            SizedBox(height: 18),

            Center(
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  onPressed:(){
                  if(FirebaseAuth.instance.currentUser==null)
                    Fluttertoast.showToast(msg: "Create an account first");

                  else
                    sslCommerzGeneralCall();

                         },

                  child:Text("Pay Now",style: TextStyle(color: Colors.white),)),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  onPressed:(){

                    if(FirebaseAuth.instance.currentUser==null)
                      Fluttertoast.showToast(msg: "Create an account first");

                    else
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return PaymentGateway();
                              }));
                         },

                  child:Text("Pay Now LIVE",style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}



Future<void> sslCommerzGeneralCall() async {
  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      //Use the ipn if you have valid one, or it will fail the transaction.
      ipn_url: "https://www.dhakacitycollege.edu.bd/",
      multi_card_name: "visa,master,bkash",
      currency: SSLCurrencyType.BDT,
      product_category: "Food",
       sdkType: SSLCSdkType.TESTBOX,
       //_radioSelected == SdkType.TESTBOX
      //     ? SSLCSdkType.TESTBOX
      //     : SSLCSdkType.LIVE,
      store_id: "trend6498c6fe4b5a2",
      store_passwd: "trend6498c6fe4b5a2@ssl",
      total_amount: 10,
      tran_id: "1231123131212",
    ),
  );
  try {
    SSLCTransactionInfoModel result = await sslcommerz.payNow();

    if (result.status!.toLowerCase() == "failed") {
      Fluttertoast.showToast(
        msg: "Transaction is Failed....",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (result.status!.toLowerCase() == "closed") {
      Fluttertoast.showToast(
        msg: "SDK Closed by User",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
          msg:
          "Transaction is ${result.status} and Amount is ${result.amount}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
