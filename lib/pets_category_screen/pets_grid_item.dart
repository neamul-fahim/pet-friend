




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class PetsCategoryGridItem extends StatelessWidget {

  final dynamic pets;
  const PetsCategoryGridItem({Key? key,this.pets}) : super(key: key);



  @override
  Widget build(BuildContext context) {

   var ImageType="asset";
     var temp=pets.imgURL[0];
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
          pets.imgURL[0].isEmpty?CircularProgressIndicator():
          ImageType=="network"?
          Container( ///pic container
          //  color: Colors.blue,
            height: dynamicHeight*0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)),
                image: DecorationImage(
                  image:CachedNetworkImageProvider(pets.imgURL[0],),fit: BoxFit.fill,
                  //NetworkImage(pets.imgURL[0]),fit: BoxFit.fill,
                )),)
          : Container( ///pic container
            //  color: Colors.blue,
            height: dynamicHeight*0.15,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage(pets.imgURL[0]),fit: BoxFit.fill,

                )),),

               Container(  ///text container
                 //height: dynamicHeight*0.08,
                 width: double.infinity,
                 //color: Colors.blue,
                 child: FittedBox(
                   fit: BoxFit.scaleDown,
                   child: pets.key=="bird"?
                   Text("${pets.name}",style: const TextStyle(fontSize: 15,),)
                       :Text("${pets.breed}",style: const TextStyle(fontSize: 15,),),
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
                      child: Text("\$${pets.price}")),
                  Spacer(),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                      child: IconButton(onPressed: (){
                         cart.addToCart(pets);
                      },
                          icon: Icon(Icons.shopping_cart_checkout_outlined,size: 40,))),
                  Spacer(),
                ],
            ),
             )



      ],
      ),
    );
  }
}

