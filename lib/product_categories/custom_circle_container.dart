import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class CustomCircleContainer extends StatefulWidget {
  String productPic;
  String productDescription;
  // int index;


   CustomCircleContainer({Key? key,
    required this.productPic,
   required this.productDescription,
    // required this.index,
  }) : super(key: key);

  @override
  State<CustomCircleContainer> createState() => _CustomCircleContainerState();
}

class _CustomCircleContainerState extends State<CustomCircleContainer> {
  @override
  Widget build(BuildContext context) {
    double dynamicHeight =MediaQuery.of(context).size.height;
    double dynamicWidth =MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [

          ///pic container SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

          PhysicalModel(
            color: Colors.black,
            shadowColor: Colors.teal,
            elevation: 20,
            shape: BoxShape.circle,
           // borderRadius: BorderRadius.circular(180),
            child: Container(
              height: dynamicHeight*0.09,
              width: dynamicWidth*0.12,
              decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  border: Border.all(width:0.1, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(widget.productPic),
                  fit: BoxFit.cover
                )
              ),

            ),
          ),
          ///pic container EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

         /// text container SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
          Container(
           // margin: const EdgeInsets.all(1.0) ,
            height: dynamicHeight*0.035,
            width: dynamicWidth*0.16,
           ///color: Colors.blue,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.productDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                fontSize: 12
              ),),
            ),
          )
          /// text container EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

        ],
      ),
    );
  }
}
