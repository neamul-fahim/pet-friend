

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart=Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: cart.cartData.isEmpty? Center(child: const Text("Add something to the cart",style: TextStyle(fontSize: 20),))
       :
      ListView.builder(
        itemCount: cart.cartData.length,
          itemBuilder: (context,i){
             return

               Row(
                 children: [
                   Container(///with out height and width the pic won't get displayed!!!!!!!!!!!!!!!!!!!
                        margin: const EdgeInsets.all(10),
                        height:50,
                          width: 50,
                           decoration:  BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image:
                              AssetImage(cart.cartData[i].imgUrl),
                                fit: BoxFit.fill,
                                //alignment:

                              )),
                         // child: Image.asset(cart.cartData[i].imgUrl,),

                        ),
                 ],
               );


                 /// CircleAvatar(backgroundImage: AssetImage(cart.cartData[i].imgUrl),),


      }),


    );
  }
}
