import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_friend/Order_screen/Order_screen.dart';

import '../model_class/cart_model_class.dart';

class ProductOverviewScreen extends StatefulWidget {

  final product;
  ProductOverviewScreen({required this.product});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  late ScaffoldMessengerState scaffoldMessengerState;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    scaffoldMessengerState=ScaffoldMessenger.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items:[
                for(int i=0;i<widget.product.imgURL.length;i++)
              Container(
                     decoration: BoxDecoration(border: Border.all(width:0.1, color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                      //color: Colors.red,
                     image: DecorationImage(
                        image: NetworkImage(widget.product.imgURL[i]),
                        fit: BoxFit.cover,
                  )
                  ),
                  )


                  ],

              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Product Description',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${widget.product.price.toString()} TK",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 100),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      ElevatedButton.icon(
                        style: ButtonStyle(
                            padding:MaterialStatePropertyAll(EdgeInsets.only(top:10,bottom: 10,left: 50,right: 50)) ,
                            backgroundColor: MaterialStatePropertyAll(Colors.teal.shade400)),
                        icon: Icon(Icons.add_shopping_cart,size: 25),
                        onPressed: () {
                          GetAndSetCartDataToFirebase().setCartDataToFirebase(widget.product, true, scaffoldMessengerState);
                          // Add to cart functionality
                        }, label: Text("Add to Cart",style: TextStyle(fontSize: 20),),
                      ),

                      SizedBox(height: 20),

                      ElevatedButton.icon(
                        style: ButtonStyle(padding:MaterialStatePropertyAll(EdgeInsets.only(top:10,bottom: 10,left: 60,right: 60)) ,
                            backgroundColor: MaterialStatePropertyAll(Colors.teal.shade400)),
                        icon: Icon(Icons.shopping_bag,size: 25),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                              OrderScreen(
                                customerName: "fahim",
                                email: "fahim@gmail.com",
                                phoneNumber: "01546621548",
                                address: "320/a,Khilgaon,Dhaka-1219",
                                productName: "parrot",
                                quantity: 7,
                                unitPrice: 100,
                                totalPrice: 700,


                              )));

                          // Buy button functionality
                        }, label: Text("Buy Now",style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
