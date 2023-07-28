


import 'package:flutter/material.dart';
import 'package:pet_friend/product_overview_screen/product_overview_screen.dart';
import 'package:provider/provider.dart';

import '../provider/accessory_provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/food_provider.dart';
import 'flash_sale_custom_container.dart';

class FlashSale extends StatefulWidget {

  final dynamic products;
  const FlashSale({Key? key, required this.products}) : super(key: key);

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  @override
  Widget build(BuildContext context) {
    double dynamicHeight = MediaQuery.of(context).size.height;
    double dynamicWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),

             //height: dynamicHeight*0.3,
        child: Column(
          children: [
            /// "FLASH SALE"  and "MORE"  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            Row(
              children: [
                Spacer(flex: 1),
                Text("New Arrivals !!!!",
                  style: TextStyle(color:Colors.red.shade900,fontSize:30 ,fontWeight:FontWeight.w600 ),),
               Spacer(flex: 5),

               Icon(Icons.arrow_forward_rounded,color: Colors.red.shade900,size: 35),

                Spacer(flex: 1),
              ],
            ),
            /// "FLASH SALE"  and "MORE"  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


            ///Product pic,description,price etc SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            ///
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,

               Container(
                 height: dynamicHeight*0.25,
                color: Colors.white12,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {

                    ///Merging description SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                    var description;

                    if((widget.products[index].key=="dog"|| widget.products[index].key=="cat") && widget.products[index].category=="pets") {
                      var t=widget.products[index];
                      description ="Colors: ${t.colors}, Age: ${t.age}, Breed: ${t.breed}, Trained: ${t.trained}";
                    }

                    if(widget.products[index].key=="bird" && widget.products[index].category=="pets") {
                      var t=widget.products[index];
                      description ="Colors: ${t.colors}, Age: ${t.age}, Can Talk: ${t.talk}, Can Fly: ${t.fly}";
                    }
                    if(widget.products[index].category=="food") {
                      var t=widget.products[index];
                      description ="${t.key} ${t.category}, Quantity: ${t.quantity}, description: ${t.description}";
                    }
                    if(widget.products[index].category=="accessory") {
                      var t=widget.products[index];
                      description ="${t.key} ${t.category}, description: ${t.description}";
                    }
                    ///Merging description EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  ProductOverviewScreen(product: widget.products[index])));
                            },

                            child: FlashSaleCustomContainer(imgURL:widget.products[index].imgURL[0] ,price:widget.products[index].price,description: description)),
                      ),
                    );
                  },
                )
                // Row(
                //  children:  [
                //    FlashSaleCustomContainer(),
                //    FlashSaleCustomContainer(),
                //    FlashSaleCustomContainer(),
                //    FlashSaleCustomContainer(),
                //
                //  ],
                // ),
              ),


           // ),  //SingleChildScrollView................................................................

            ///Product pic,description,price etc EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

          ],
        ),
      ),
    );
  }
}
