

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart=Provider.of<CartProvider>(context);
    var ImageType="asset";
    var temp;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: cart.cartData.isEmpty? Center(child: const Text("Add something to the cart",style: TextStyle(fontSize: 20),))
       :
      ListView.builder(
        itemCount: cart.cartData.length,
          itemBuilder: (context,i){
            temp=cart.cartData[i][0].imgURL[0];
            if(temp[0]=="h" && temp[1]=="t" && temp[2]=="t" && temp[3]=="p") ImageType="network";

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal.shade50,

                ),
                child: Row(
                     children: [

                 ImageType=="network"?
                       Container(///with out height and width the pic won't get displayed!!!!!!!!!!!!!!!!!!!
                            margin: const EdgeInsets.all(10),
                            height:50,
                              width: 50,
                               decoration:  BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(cart.cartData[i][0].imgURL[0]),
                                    fit: BoxFit.fill,
                                    //alignment:

                                  )),
                             // child: Image.asset(cart.cartData[i].imgUrl,),

                            )
                 :
                  Container(///with out height and width the pic won't get displayed!!!!!!!!!!!!!!!!!!!
                            margin: const EdgeInsets.all(10),
                            height:50,
                              width: 50,
                               decoration:  BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(image:
                                  AssetImage(cart.cartData[i][0].imgURL[0]),
                                    fit: BoxFit.fill,
                                    //alignment:

                                  )),
                             // child: Image.asset(cart.cartData[i].imgUrl,),

                            ),
                           Spacer(flex: 8,),
                           IconButton(onPressed: (){
                             if(cart.cartData[i][1]>1)
                                     cart.reduceItemCount(cart.cartData[i][0]);
                           },
                               icon: Icon(Icons.do_disturb_on_outlined,color: Colors.black,)),
                           Container(

                             child: Text(cart.cartData[i][1].toString(),style: TextStyle(fontSize: 18),),
                           ),
                       IconButton(onPressed: (){
                         cart.addToCart(cart.cartData[i][0]);
                       },
                           icon: Icon(Icons.add_circle_outline,color: Colors.black,)),
                       IconButton(onPressed:(){
                         cart.deleteItem(cart.cartData[i][0]);
                       },
                           icon: Icon(Icons.delete,color: Colors.red,)),

                       Spacer(flex: 1),
                     ],
                   ),
              ),
            );

                 /// CircleAvatar(backgroundImage: AssetImage(cart.cartData[i].imgUrl),),

      }),
    );
  }
}
