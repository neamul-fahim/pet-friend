




import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/model_class/cart_model_class.dart';
import 'package:provider/provider.dart';

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





   return Container(
        //height: dynamicHeight*0.02,
       // width: dynamicWidth*0.9,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        border:Border.all(color:Colors.teal)

      ),
      child: Column(
        children: [
          // widget.pets.imgURL[0].isEmpty?const CircularProgressIndicator():
          // ImageType=="network"?
          Container( ///pic container for network image
          //  color: Colors.blue,
            height: dynamicHeight*0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)),
                image: DecorationImage(
                  image:CachedNetworkImageProvider(widget.pets.imgURL[0],),fit: BoxFit.fill,
                  //NetworkImage(pets.imgURL[0]),fit: BoxFit.fill,
                )),),


               Container(  ///text container
                 //height: dynamicHeight*0.08,
                 width: double.infinity,
                 //color: Colors.blue,
                 child: FittedBox(
                   fit: BoxFit.scaleDown,
                   child: //widget.pets.key=="bird"?
                   Text("${widget.pets.name}",style: const TextStyle(fontSize: 15,),),
                       //:Text("${widget.pets.breed}",style: const TextStyle(fontSize: 15,),),
                 ),
               ),

             Container(  ///price and cart icon
               //color: Colors.pinkAccent,
               width: double.infinity,
               height: dynamicHeight*0.05,
               child: Row(
                children: [
                Spacer(),
                  FittedBox( fit:BoxFit.scaleDown,
                      child: Text("\$${widget.pets.price}")),
                  Spacer(),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                      child: AbsorbPointer(
                        absorbing: clickAbsorb,
                        child: IconButton(onPressed: (){
                          setState(() {
                            clickAbsorb=true;
                          });
                          print("***************************************************${widget.pets.firebasePath}************************");

                          if(FirebaseAuth.instance.currentUser==null) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Center(
                                    child: Text("Don't have an account"))));
                            return;
                          }
                         // print("***************************************************${pets.firebasePath}************************");

                          GetAndSetCartDataToFirebase().setCartDataToFirebase(widget.pets, true,scaffoldMessengerState).then((value) {
                            setState(() {
                              clickAbsorb=false;
                            });
                          }

                          );
                          // if(pets.firebasePath!=null)
                          // cart.addToCart(pets);
                        },
                            icon: Icon(Icons.shopping_cart_checkout_outlined,size: 40,)),
                      )),
                  const Spacer(),
                ],
            ),
             )
      ],
      ),
    );
  }
}

