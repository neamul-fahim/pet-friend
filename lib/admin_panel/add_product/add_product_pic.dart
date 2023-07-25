

import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_friend/model_class/bird_model_class.dart';

class AddProductPic extends StatefulWidget {

   dynamic fireData;

    AddProductPic({Key? key,
    required this.fireData,
  }) : super(key: key);

  @override
  State<AddProductPic> createState() => _AddProductPicState();
}

          var firebaseStorage=FirebaseStorage.instance.ref();
           final fireStore=FirebaseFirestore.instance;
           bool isUploading=false;



class _AddProductPicState extends State<AddProductPic> {

  List<io.File>listOfPic=[];
  List<String>storageRef=[];

  @override
  Widget build(BuildContext context) {
    var dSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ///to show selected pictures SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
          Expanded(
            flex: 4,
            child: GridView.count(
              padding: EdgeInsets.all(8),
                crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 2,
              childAspectRatio: 1,
              children: [
                for(int i=0;i<(listOfPic.length>5?5:listOfPic.length);i++)
                  Image.file(listOfPic[i])

              ],
            ),
          ),
          ///to show selected pictures EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


         /// select picture from gallery or camera only 5 pics are allowed SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
          if(listOfPic.length<5)
          Flexible(
            child: ElevatedButton.icon(
              style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.teal[400]) ),
                onPressed:(){


                showDialog(
                    context: context, builder: (_){
                      var width=MediaQuery.of(context).size.width;
                  return AlertDialog(
                    title: Padding(
                      padding: EdgeInsets.only(left:width*0.6),
                      child: IconButton(
                         icon: const Icon(Icons.cancel),
                        onPressed: (){
                           Navigator.of(context).pop();
                        },
                      ),
                    ),
                    alignment: Alignment.center,
                    actionsAlignment: MainAxisAlignment.center,

                    content: const Text("Choose one option to upload image"),
                    actions: [
                      ElevatedButton.icon(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal[400])),
                          onPressed:()async{
                            Navigator.of(context).pop();

                            final ImagePicker picker = ImagePicker();

                            final XFile? image = await picker.pickImage(imageQuality: 50,source: ImageSource.camera);
                            if(image==null) return;

                            setState(() {
                              listOfPic.add(io.File(image.path));
                            });

                          } ,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Camera")),
                      ElevatedButton.icon(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal[400])),
                          onPressed:()async{
                            Navigator.of(context).pop();
                            final ImagePicker picker = ImagePicker();
                            final List<XFile> images = await picker.pickMultiImage(imageQuality:50,);
                         setState(() {
                           listOfPic+=images.map((e) => io.File(e.path)).toList();

                         });
                          } ,
                          icon: const Icon(Icons.image),
                          label: const Text("Gallery")),
                    ],
                  );
                });
                },
                icon: const Icon(Icons.camera_alt
                ),
                label: const Text("Add image"),
            ),
          ),

          /// select picture from gallery or camera only 5 pics are allowed EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE



        /// "Save data" button for uploading data to firebase SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
          Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top:40),

                child:
                    isUploading?const CircularProgressIndicator():
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal[400])),
                    onPressed: ()async{

                      setState(() {
                        isUploading=true;
                      });
                      var docID;
                      //print(widget.fireData.category);
                      if (widget.fireData.category=="pets") ///for pets
                       docID= fireStore.collection("products").doc(widget.fireData.category).collection(widget.fireData.key).doc();
                      else
                        docID= fireStore.collection("products").doc(widget.fireData.category).collection("allTypes").doc();///for accessories and food


                      ///firebaseStorage pic upload SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                 for(int i=0;i<(listOfPic.length>5?5:listOfPic.length);i++) {
                   var fireStorePath=firebaseStorage
                       .child("pet_friend").child("products").child(widget.fireData.category!).child(docID.id).child("pic${i+1}");
                        await fireStorePath.putFile(listOfPic[i]);
                         var imgURL=await fireStorePath.getDownloadURL();
                        storageRef.add(imgURL);
                      }
                      ///firebaseStorage pic upload EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE



                      /// fireStore data upload SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                      widget.fireData.imgURL=storageRef;
                          widget.fireData.id=docID.id;
                          if(widget.fireData.category=="pets")
                          widget.fireData.firebasePath="products/${widget.fireData.category}/${widget.fireData.key}/${docID.id}";

                          else
                            widget.fireData.firebasePath="products/${widget.fireData.category}/${"allTypes"}/${docID.id}";


                      await docID.set(
                         widget.fireData.toFirebase(),SetOptions(merge: true)).then((value){
                           setState(() {
                             isUploading=false;
                             Navigator.pop(context);
                           });
                           /// fireStore data upload SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                           print("55555555555555555555555555555555555555555555555555555555555555555555555555555555555");


                           ScaffoldMessenger.of(context).clearSnackBars();

                                 ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Center(child: Text("data uploaded to server"))));

                      }).catchError((err){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(err.toString()))));///err.message !!!!!
                      });

                      setState(() {
                        listOfPic.clear();
                      });
                    },

                    child: const Text("Save data")),
              ))

          /// "Save data" button for uploading data to firebase EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

        ],
      ),
    );
  }
}
