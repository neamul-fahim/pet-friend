


import 'package:flutter/material.dart';

import '../utills/colors.dart';
import 'flash_sale_product_pic_and_description.dart';

class FlashSaleCustomContainer extends StatefulWidget {
  const FlashSaleCustomContainer({Key? key}) : super(key: key);

  @override
  State<FlashSaleCustomContainer> createState() => _FlashSaleCustomContainerState();
}

  double price = 100000;  ///
   FlashSaleProductPicAndDescription flashSaleProductPicAndDescription=FlashSaleProductPicAndDescription();///

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
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(20)

      ),

        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Product pic SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              Padding(
                padding:  EdgeInsets.all(10.0),
                child: Container(
                  height: dynamicHeight*0.3,
                 width: dynamicWidth*0.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    image:  DecorationImage(
                      image: AssetImage(flashSaleProductPicAndDescription.productPic[0]),
                      fit: BoxFit.cover

                    )
                  ),
                ),
              ),
              ///Product pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
              const VerticalDivider(color: Colors.black,thickness: 0.8,indent: 30,endIndent: 30,),
       ///Product description,price,rating etc SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Container(
                   decoration: BoxDecoration(
                     color: allColors.themeColorFade,
                     borderRadius: BorderRadius.circular(10)
                   ),

                   child: Column(
                     children: [

                       TextContainer(dynamicWidth,"It is a four wheeler with tremendous horse power",
                           Colors.black,FontWeight.w400,18),
                       TextContainer(dynamicWidth,"Price: \$$price",Colors.red,FontWeight.w700,18),

                     ],
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