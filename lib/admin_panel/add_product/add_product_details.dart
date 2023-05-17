
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/admin_panel/add_product/add_product_pic.dart';
import 'package:pet_friend/admin_panel/add_product/bird_details_form.dart';
import 'package:pet_friend/model_class/bird_model_class.dart';

class AddProduct extends StatefulWidget {


   AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}
    List<String> proList=<String>["Select Category","bird","dog","cat","food","accessory"];
class _AddProductState extends State<AddProduct> {

  /////////////////////////////////////////////////////////////////////////////////////
  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorsController = TextEditingController();
  final TextEditingController talkController = TextEditingController();
  final TextEditingController flyController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<String> _listOfColors = [];

  @override
  void dispose() {
    nameController.dispose();
    colorsController.dispose();
    talkController.dispose();
    flyController.dispose();
    ageController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void clearConstructors(){
    nameController.clear();
    colorsController.clear();
    talkController.clear();
    flyController.clear();
    ageController.clear();
    priceController.clear();
  }

  void _addStringToList() {
    setState(() {
      var temp=colorsController.text;
      var temp1=temp.split(",");
      _listOfColors=temp1.map((e) => e.trim()).toList();//_listOfColors+=temp1;
     // _colorsController.clear();
    });
  }
     ////////////////////////////////////////////////////////////////////////////

    final _formKey=GlobalKey<FormState>();
   String firstItem=proList[0];

  @override
  Widget build(BuildContext context) {
    var dSize=MediaQuery.of(context).size;

    //print("${firstItem[6]} +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0,left: 50,right: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// drop down button for selecting product cat SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  DropdownButtonFormField(

                    decoration: InputDecoration(
                        border:OutlineInputBorder()
                    ),
                    value: firstItem,
                      validator: ((v){
                        if(v=="Select Category") return "select a valid option";
                         return null;
                      }),
                      items:proList.map((e) => DropdownMenuItem(child: Text(e),
                      value: e,)).toList() ,
                      onChanged:(v){

                        setState(() {
                          firstItem=v.toString();
                        });
                      } ),

                  /// drop down button for selecting product cat EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE





                   if(firstItem=="bird")
                    BirDetailsForm(
                        nameController: nameController,
                        colorsController: colorsController,
                        talkController: talkController,
                        flyController: flyController,
                        ageController: ageController,
                        priceController: priceController),

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                          _addStringToList();///might have problem
                          var fireData=BirdModelClass(
                            name: nameController.text,
                            colors:_listOfColors,
                            talk: talkController.text,
                            fly: flyController.text,
                            age: ageController.text,
                            price: double.parse(priceController.text),
                          );
                          fireData.key=firstItem;

                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return AddProductPic(fireData: fireData);}));

                          //clearConstructors();


                        // Do something when the form is submitted
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),


                ],
              ),
            ),
          ),
        ),
    );
  }
}
