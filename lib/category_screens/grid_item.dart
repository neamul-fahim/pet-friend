




import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/model_class/cart_model_class.dart';
import 'package:provider/provider.dart';

import '../product_overview_screen/product_overview_screen.dart';
import '../provider/cart_provider.dart';

class GridItem extends StatefulWidget {

  final dynamic pets;

   GridItem({Key? key,this.pets}) : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  late ScaffoldMessengerState scaffoldMessengerState;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    scaffoldMessengerState=ScaffoldMessenger.of(context);
  }




  var clickAbsorb=false;

  void sendToFirebase(dynamic pets){
      CartModelClass(firebasePath: pets.firebasePath, );
  }

  @override
  Widget build(BuildContext context) {

   var ImageType="asset";
     var temp=widget.pets.imgURL[0];
     if(temp[0]=="h" && temp[1]=="t" && temp[2]=="t" && temp[3]=="p") ImageType="network";

      var cart=Provider.of<CartProvider>(context);
    double dynamicHeight =MediaQuery.of(context).size.height;
    double dynamicWidth =MediaQuery.of(context).size.width;





   return
     Card(
     shadowColor: Colors.teal,
     elevation: 30,
     color: Colors.teal,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),

        child: Column(
          mainAxisSize: MainAxisSize.min, // Use MainAxisSize.min to take the minimum height required
          children: [
            // widget.pets.imgURL[0].isEmpty?const CircularProgressIndicator():
            // ImageType=="network"?
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return ProductOverviewScreen(product:widget.pets);
                    }));
                  },
                  child:
                  Image.network(
                    widget.pets.imgURL[0],
                    fit: BoxFit.fill,
                  ),

                  // Container( ///pic container for network image
                  // //  color: Colors.blue,
                  //   height: dynamicHeight*0.15,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)),
                  //       image: DecorationImage(
                  //         image:NetworkImage(widget.pets.imgURL[0],),fit: BoxFit.fill,
                  //         //NetworkImage(pets.imgURL[0]),fit: BoxFit.fill,
                  //       )),),

                ),
              ),
            ),

            SizedBox(height: 3.0),
            Expanded(
              flex: 1,
              child: Text(
                widget.pets.name,
                textAlign: TextAlign.center, // Center the text within its space
                style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),

            Divider(height: 3,color: Colors.black,indent: 10,endIndent: 10,thickness: 0.5),

            FittedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${widget.pets.price} tk",style: TextStyle(fontSize: 20,color: Colors.white),),
                    SizedBox(width: 16.0), // Add spacing between widgets if needed
                    IconButton(
                      onPressed: () {
                        print("***************************************************${widget.pets.firebasePath}************************");

                        if (FirebaseAuth.instance.currentUser == null) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Center(child: Text("Don't have an account"))),
                          );
                          return;
                        }

                        GetAndSetCartDataToFirebase().setCartDataToFirebase(widget.pets, true, scaffoldMessengerState)
                            .then((value) {
                          // Perform actions after adding to cart if needed
                        });
                      },
                      icon: Icon(Icons.shopping_cart_checkout_outlined, size: 40,color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
        ],
        ),
      ),
    );
  }
}

