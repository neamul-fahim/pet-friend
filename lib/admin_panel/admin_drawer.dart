import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_product/add_product_details.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dSize=MediaQuery.of(context).size;
    return  Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: dSize.height*0.05),
            /// profile plus cancel button part SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                // color: Colors.white,
                width: dSize.width,
                height: dSize.height*0.25,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex:3,
                      child: Container(       ///test container
                        //color: Colors.red,

                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: [
                              CircleAvatar(     ///circular profile pic
                                  radius: dSize.aspectRatio*200,
                                  backgroundColor: Colors.black),

                              ///profile name
                              Text("Name",style: TextStyle(color: Colors.black,fontSize: dSize.aspectRatio*60),),
                            ],
                          ),
                        ),
                      ),
                    ),


                    Expanded(
                      flex: 1,
                      child: Container(
                        // padding: EdgeInsets.only(top: 150),///test container
                        // color: Colors.yellow,
                        child: IconButton(///drawer cancel button
                          alignment: Alignment.topRight,
                          color: Colors.black,
                          icon: Icon(Icons.cancel,size: dSize.width*0.08),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),

                  ],

                ),
              ),
            ),
            /// profile plus cancel button part EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

          ),

          SizedBox(height:dSize.height*0.1,),

          TextButton.icon(

            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return
                  AddProduct();
              }));
            },
            label: Text("Add Item",style: TextStyle( fontSize: 20,color: Colors.black),),
            icon:Icon(Icons.add_circle_rounded,size: dSize.width*0.08,color: Colors.black,) ,
          ),


        ],
      ),
      backgroundColor: Colors.teal.shade300,
    );

  }
}
