import 'package:flutter/material.dart';
import 'package:pet_friend/model_class/app_drawer_model_class.dart';

  class AdminPanel extends StatelessWidget {
    const AdminPanel({Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
      var dSize=MediaQuery.of(context).size;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        drawer:Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: dSize.height*0.05),
                /// profile plus cancel button part SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    //color: Colors.red,
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
                            //color: Colors.yellow,

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
                        child: Container( ///test container
                          //color: Colors.white,
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

              },
                  label: Text("Add Item",style: TextStyle( fontSize: 20,color: Colors.black),),
                icon:Icon(Icons.add_circle_rounded,size: dSize.width*0.08,color: Colors.black,) ,
              ),


            ],
          ),
          backgroundColor: Colors.teal.shade100,
        ),
        body: Container(
          decoration:BoxDecoration(
            color:Colors.white,
          ),
        ),
      );
    }
  }
