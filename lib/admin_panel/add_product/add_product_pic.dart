

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
          if(listOfPic.length<=5)
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
                         icon: Icon(Icons.cancel),
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
// Pick an image.
                            final XFile? image = await picker.pickImage(source: ImageSource.camera);
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
                icon: Icon(Icons.camera_alt
                ),
                label: const Text("Add image"),
            ),
          ),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top:40),

                child:
           isUploading?CircularProgressIndicator():
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal[400])),
                    onPressed: ()async{

                      setState(() {
                        isUploading=true;
                      });

                      var docID= fireStore.collection("products").doc(widget.fireData.category).collection(widget.fireData.key).doc();

                      for(int i=0;i<(listOfPic.length>5?5:listOfPic.length);i++) {
                        var temp=firebaseStorage.child("pet_friend").child("products").child(widget.fireData.key!).child(docID.id).child("pic${i+1}");
                      await temp.putFile(listOfPic[i]);
                         var imgURL=await temp.getDownloadURL();
                        storageRef.add(imgURL);
                      }

                      widget.fireData.imgURL=storageRef;
                          widget.fireData.id=docID.id;
                               await docID.set(
                         widget.fireData.toFirebase(),SetOptions(merge: true)).then((value){

                                 setState(() {
                                   isUploading=false;
                                 });


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
        ],
      ),
    );
  }
}
