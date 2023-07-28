


import 'package:flutter/material.dart';

import '../utills/colors.dart';
import 'flash_sale_product_pic_and_description.dart';

class FlashSaleCustomContainer extends StatefulWidget {

  final String imgURL;
  final String description;
  final double price;
  const FlashSaleCustomContainer({Key? key,
    required this.imgURL,
    required this.description,
    required this.price}) : super(key: key);

  @override
  State<FlashSaleCustomContainer> createState() => _FlashSaleCustomContainerState();
}


  AllColors allColors=AllColors();



class _FlashSaleCustomContainerState extends State<FlashSaleCustomContainer> {
  @override
  Widget build(BuildContext context) {


    double dynamicHeight =MediaQuery.of(context).size.height;///
    double dynamicWidth =MediaQuery.of(context).size.width;///



    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(

      decoration: BoxDecoration(

        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 10),
            // changes the position of the shadow
          ),
        ],
        color: Colors.teal.shade300,
        borderRadius: BorderRadius.circular(10)

      ),

        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Product pic SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              Container(
                height: dynamicHeight*0.3,
               width: dynamicWidth*0.4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  image:  DecorationImage(
                    image: NetworkImage(widget.imgURL),
                    fit: BoxFit.cover

                  )
                ),
              ),
              ///Product pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
              const VerticalDivider(color: Colors.black,thickness: 0.8,indent: 30,endIndent: 30,width: 0.5),
              ///Product description,price,rating etc SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: FittedBox(fit: BoxFit.fill,
                   child: Container(
                     decoration: BoxDecoration(
                       color: allColors.themeColorFade,
                       borderRadius: BorderRadius.circular(10)
                     ),

                     child: Column(
                       children: [

                         FittedBox(child: TextContainer(dynamicWidth,widget.description,Colors.black,FontWeight.w400,18)),
                         FittedBox(child: TextContainer(dynamicWidth,"Price: ${widget.price}",Colors.red,FontWeight.w700,18)),

                       ],
                     ),
                   ),
                 ),
               )

              ///Product description,price,rating etc EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


            ],
          ),
        ),
      ),
    );
  }
}



 Widget TextContainer(double dynamicWidth,String textData,Color textColor,FontWeight fontWeight,double fontSize){
  return Container(
     //color: Colors.red,
     width: dynamicWidth*0.35,
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Text(textData,style: TextStyle(color: textColor,fontWeight:fontWeight ,fontSize: fontSize),),
     ),
   );
 }