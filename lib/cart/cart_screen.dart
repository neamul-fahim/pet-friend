

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/model_class/cart_model_class.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}


class _CartState extends State<Cart> {

  bool once=true;

  List<dynamic> cartData=[];
  bool load=false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   print("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
  //   fun();
  //   super.initState();
  // }
  final db=FirebaseFirestore.instance;

  var uid=FirebaseAuth.instance.currentUser?.uid;


  var item = CartModelClass();

  Future <void> fun() async {
    cartData=[];
    print("${cartData.length}/////////////////////////////////111111111111//////////////////////////////////////");


    var fireCartData = await db.collection("users").doc(uid).collection("cart").get();
   print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
   print("${fireCartData.docs.length}*************************************************************");
   for(int i=0;i<fireCartData.docs.length;i++) {
     item=CartModelClass();
     var data=fireCartData.docs[i].data();

     var path= await db.doc(data["firebasePath"]).get();
     item.productQuantity=data["productQuantity"];
     item.imgURL=path["imgURL"][0];
     item.id=path["id"];
     item.firebasePath=path["firebasePath"];
     //print("${item.id}*****************************************************************************");

     cartData.add(item);
     print("${cartData.length}//////////////////////////////////////////////////////////////////////////////");
   }
    // if (value.data()?["imgURL"][0]=="h" && temp[1]=="t" && temp[2]=="t" && temp[3]=="p") ImageType="network";
    once=false;
    setState(() {
      load=true;
      print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    });
  }


  @override
  Widget build(BuildContext context) {


  var cart=Provider.of<CartProvider>(context);
    if(once)fun();
   print("${cartData.length}LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");


  return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: !load && cartData.isEmpty?
          const Center(child:CircularProgressIndicator() )
      :
          load && cartData.isEmpty?
          const Center(child: Text("Empty"))
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

                           Container(///with out height and width the pic won't get displayed!!!!!!!!!!!!!!!!!!!
                                margin: const EdgeInsets.all(10),
                                height:50,
                                  width: 50,
                                   decoration:  BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(cartData[i].imgURL),
                                        fit: BoxFit.fill,
                                      )),
                                ),



                               Spacer(flex: 8,),
                               IconButton(onPressed: (){
                                 if(cartData[i].productQuantity>1)
                                   GetAndSetCartDataToFirebase().setCartDataToFirebase(cartData[i],false, context)
                                       .then((value) => setState(() {
                                     once=true;load=false;
                                   })
                                   );                               },
                                   icon: Icon(Icons.do_disturb_on_outlined,color: Colors.black,)),

                               Container(

                                 child: Text(cartData[i].productQuantity.toString(),style: TextStyle(fontSize: 18),),
                               ),
                           IconButton(onPressed: (){
                             GetAndSetCartDataToFirebase().setCartDataToFirebase(cartData[i],true, context)
                                 .then((value) => setState(() {
                               print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
                               once=true;load=false;
                             })
                             );

                           },
                               icon: Icon(Icons.add_circle_outline,color: Colors.black,)),

                           IconButton(onPressed:(){
                             GetAndSetCartDataToFirebase().DeleteCartItem(cartData[i])
                                 .then((_)
                                 {
                                   ScaffoldMessenger.of(context).clearSnackBars();
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item deleted")));
                                   setState(() {
                                     once=true;load=false;
                                   });

                                 }
                             );
                           },
                               icon: Icon(Icons.delete,color: Colors.red,)),

                           Spacer(flex: 1),
                         ],
                       ),
                  ),
                );
                /// CircleAvatar(backgroundImage: AssetImage(cart.cartData[i].imgUrl),),

          })
    );
  }
}
