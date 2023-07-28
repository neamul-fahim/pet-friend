
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_friend/Order_screen/Order_screen.dart';
import 'package:pet_friend/model_class/user_data_model.dart';

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



    var description;

    if((widget.product.key=="dog"||widget.product.key=="cat") && widget.product.category=="pets") {
     var t=widget.product;
      description ="Colors: ${t.colors}, Age: ${t.age}, Breed: ${t.breed}, Trained: ${t.trained}";
    }

    if(widget.product.key=="bird" && widget.product.category=="pets") {
     var t=widget.product;
      description ="Colors: ${t.colors}, Age: ${t.age}, Can Talk: ${t.talk}, Can Fly: ${t.fly}";
    }
    if(widget.product.category=="food") {
     var t=widget.product;
      description ="${t.key} ${t.category}, Quantity: ${t.quantity}, description: ${t.description}";
    }
    if(widget.product.category=="accessory") {
     var t=widget.product;
      description ="${t.key} ${t.category}, description: ${t.description}";
    }





    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 40,),

            CarouselSlider(
              items:[
                for(int i=0;i<widget.product.imgURL.length;i++)
              Container(
                     decoration: BoxDecoration(
                         boxShadow: [
                           BoxShadow(
                             color: Colors.teal.shade300,
                             spreadRadius: 5,
                             blurRadius: 10,
                             // changes the position of the shadow
                           ),
                         ],

                         border: Border.all(width:0.1, color: Colors.black),
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

            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  SizedBox(height: 8),
                  Text(
                    description,
                    // "Colors: ${widget.product.colors}, Age: ${widget.product.age}, "
                    //     " ${widget.product.key=="dog" || widget.product.key=="cat" ? "${"Trained: "+ widget.product.trained} Breed: "+widget.product.breed:""}, "
                    //       "${widget.product.key=="bird"? "${"Can Talk: "+widget.product.talk} Can Fly: "+widget.product.fly:""}",
                    //
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),


                  SizedBox(height: 40),
                  Text(
                    "${widget.product.price.toString()} TK",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 60),

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

                          UserDataRepository().getFireData().then((value) =>{
                          UserDataRepository().getCartFireData(widget.product.id).then((quantity) =>{
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                OrderScreen(
                                  customerName: value.name.toString(),
                                  email: value.email.toString(),
                                  phoneNumber:  value.phone.toString(),
                                  address: value.address.toString(),
                                  productName: widget.product.name,
                                  quantity: quantity,
                                  unitPrice: widget.product.price,
                                  totalPrice: quantity*widget.product.price,
                                  imgURL: widget.product.imgURL[0],
                                )))

                          })

                          });


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
