

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/model_class/cart_model_class.dart';
import 'package:pet_friend/product_overview_screen/product_overview_screen.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();


}


class _CartState extends State<Cart> {

  late ScaffoldMessengerState scaffoldMessengerState;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    scaffoldMessengerState=ScaffoldMessenger.of(context);
  }

  final db=FirebaseFirestore.instance;
  var uid=FirebaseAuth.instance.currentUser?.uid;
  bool once=true;
  bool clickAbsorb = false;
  bool load=false;
  List<dynamic> cartData=[];

  var item = CartModelClass();





  @override
  Widget build(BuildContext context) {


    Future <void> fun() async {

      cartData=[];

      var fireCartData = await db.collection("users").doc(uid).collection("cart").get();
      for(int i=0;i<fireCartData.docs.length;i++) {
        var data = fireCartData.docs[i].data();

        var path = await db.doc(data["firebasePath"]).get();
        if (path.exists){
          item = CartModelClass();

        ///common for all models SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
        item.id = path["id"];
        item.name = path["name"];
        item.firebasePath = path["firebasePath"];
        item.category = path["category"];
        item.key = path["key"];
        item.price = path["price"];
        item.imgURL = path["imgURL"];
        item.productQuantity = data["productQuantity"];

        ///common for all models EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        print(
            "TTTTTTTTTTTTTTTTTTTTTTTTTTTT111111111111111111111111111111111TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");


        if (item.category == "pets" &&
            (item.key == "dog" || item.key == "cat")) {
          item.colors = path["colors"];
          item.breed = path["breed"];
          item.trained = path["trained"];
          item.age = path["age"];
        }

        print(
            "TTTTTTTTTTTTTTTTTTTTTTTTTTTT2222222222222222222222222222222TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");


        if (item.category == "pets" && item.key == "bird") {
          item.colors = path["colors"];
          item.talk = path["talk"];
          item.fly = path["fly"];
          item.age = path["age"];
        }

        print(
            "TTTTTTTTTTTTTTTTTTTTTTTTTTTT333333333333333333333333333333333333TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");

        if (item.category == "accessory" && item.category == "food")
          item.description = path["description"];

        if (item.category == "food") item.quantity = path["quantity"];

        print(
            "TTTTTTTTTTTTTTTTTTTTTTTTTTTT444444444444444444444444444444444444TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");


        cartData.add(item);
      }
        else {
          await db.collection("users").doc(uid).collection("cart").doc(fireCartData.docs[i].id).delete();
        }


      }
      once=false;
      setState(() {
        load=true;
      });
    }


    if(once)fun();


  return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: !load?
          const Center(child:CircularProgressIndicator() )
      :
          load && cartData.isEmpty?
          const Center(child: Text("Add something to the cart",style: TextStyle(fontSize: 25,color: Colors.black38),))
          :
      ListView.builder(
            itemCount: cartData.length,
              itemBuilder: (context,i){

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal.shade50,

                    ),
                    child: Row(
                         children: [

                           InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductOverviewScreen(product: cartData[i])));
                             },
                             child: Row(
                               children: [
                                 Container(///with out height and width the pic won't get displayed!!!!!!!!!!!!!!!!!!!
                                   margin: const EdgeInsets.all(10),
                                   height:50,
                                   width: 50,
                                   decoration:  BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       image: DecorationImage(
                                         image: NetworkImage(cartData[i].imgURL[0]),
                                         fit: BoxFit.fill,
                                       )
                                   ),
                                 ),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(cartData[i].name,style: TextStyle(fontSize: 18),),
                                     Text("${cartData[i].price.toStringAsFixed(2)} TK"),
                                   ],),

                               ],
                             )

                           ),




                               const Spacer(flex: 8),
                               AbsorbPointer(
                                 absorbing: clickAbsorb,
                                 child: IconButton(onPressed: (){
                                   setState(() {
                                     load=false;
                                     clickAbsorb=true;
                                   });
                                   if(cartData[i].productQuantity>1) {
                                     GetAndSetCartDataToFirebase().setCartDataToFirebase(cartData[i],false, scaffoldMessengerState)
                                         .then((value) {
                                       clickAbsorb=false; fun();
                                     });
                                   }                       },
                                     icon: const Icon(Icons.do_disturb_on_outlined,color: Colors.black,)),
                               ),



                               Container(

                                 child: Text(cartData[i].productQuantity.toString(),style: const TextStyle(fontSize: 18),),
                               ),



                           AbsorbPointer(
                             absorbing: clickAbsorb,
                             child: IconButton(onPressed: (){
                               setState(() {
                                 load=false;
                                 clickAbsorb=true;
                               });

                               setState(() {
                               GetAndSetCartDataToFirebase().setCartDataToFirebase(cartData[i],true, scaffoldMessengerState)
                                   .then((value) {
                                     clickAbsorb=false; fun();
                                   });
                               });
                             },
                                 icon: const Icon(Icons.add_circle_outline,color: Colors.black,)),
                           ),



                           AbsorbPointer(
                             absorbing: clickAbsorb,
                             child: IconButton(onPressed:(){
                               setState(() {
                                 load=false;
                                 clickAbsorb=true;
                               });
                               GetAndSetCartDataToFirebase().DeleteCartItem(cartData[i],scaffoldMessengerState)
                                   .then((value) {
                                     clickAbsorb=false; fun();
                               });
                             },
                                 icon: const Icon(Icons.delete,color: Colors.red,)),
                           ),

                           const Spacer(flex: 1),
                         ],
                       ),
                  ),
                );
                /// CircleAvatar(backgroundImage: AssetImage(cart.cartData[i].imgUrl),),

          })
    );
  }
}
