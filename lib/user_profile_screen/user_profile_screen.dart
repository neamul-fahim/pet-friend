

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';

import '../model_class/user_data_model.dart';



class UserProfileScreen extends StatefulWidget {
  final String uid;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final String profilePicture;

  UserProfileScreen({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.profilePicture,
  });

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}




         FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
         User? user=FirebaseAuth.instance.currentUser;
         FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
         final fireStore=FirebaseFirestore.instance;
         var firebaseStorage=FirebaseStorage.instance.ref();




class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  dynamic proPic;
  bool picChosen=false;



  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    phoneNumberController.text = widget.phoneNumber;
    emailController.text = widget.email;
    addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {



    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            InkWell(
              onTap:
                  (){

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
                              picChosen=true;
                              proPic=io.File(image.path);
                            });

                          } ,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Camera")),
                      ElevatedButton.icon(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal[400])),
                          onPressed:()async{
                            Navigator.of(context).pop();
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(imageQuality:50, source:ImageSource.gallery,);
                            if(image==null) return;

                            setState(() {
                              picChosen=true;
                              proPic=io.File(image.path);

                            });
                          } ,
                          icon: const Icon(Icons.image),
                          label: const Text("Gallery")),
                    ],
                  );
                });

              },
              child: picChosen?CircleAvatar(
                backgroundColor: Colors.teal,
                backgroundImage: FileImage(proPic),
                radius: 60.0,
              )
              :CircleAvatar(
                backgroundColor: Colors.teal,
                backgroundImage: NetworkImage(widget.profilePicture),
                radius: 60.0,
              ),
            ),
            SizedBox(height: 20.0),
            _buildTextField("Name", Icons.person, nameController),
            _buildTextField("Phone Number", Icons.phone, phoneNumberController),
            _buildTextField("Address", Icons.location_on, addressController),

            SizedBox(height:60.0),

            Container(
              height: dynamicHeight*0.06,
              width: dynamicWidth*0.4,
              child: ElevatedButton(

                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
                  onPressed:(){
                    FocusScope.of(context).unfocus();
                    saveUserData();
                  } ,
                  child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement the edit functionality
              // You can show a dialog or navigate to an edit screen to update the fields.
            },
            icon: Icon(Icons.edit, color: Colors.teal),
          ),
        ],
      ),
    );
  }
  Future<void> saveUserData ()async{
    var imgURL;
    ///profile Pic save SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    if(proPic!=null) {
      var fireStorePath = firebaseStorage
          .child("pet_friend").child("users").child(user!.uid).child("pics");
      await fireStorePath.putFile(proPic);
       imgURL = await fireStorePath.getDownloadURL();
    }
    ///profile Pic save EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


    UserDataModel userDataModel=UserDataModel(
      uid: widget.uid.trim(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneNumberController.text.trim(),
      address: addressController.text.trim(),
      profilePicURL: proPic!=null?imgURL.trim():widget.profilePicture.trim(),
    );

    /// user data save SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    await firebaseFirestore.collection("users").doc(user?.uid).set(userDataModel.toMap());
    /// user data save EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
    Fluttertoast.showToast(msg: "Data saved successfully");
  }

}


