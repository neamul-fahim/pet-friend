
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/admin_panel/add_product/accessories_details_form.dart';
import 'package:pet_friend/admin_panel/add_product/add_product_pic.dart';
import 'package:pet_friend/admin_panel/add_product/bird_details_form.dart';
import 'package:pet_friend/admin_panel/add_product/cat_details_form.dart';
import 'package:pet_friend/admin_panel/add_product/dog_details_form.dart';
import 'package:pet_friend/model_class/accessory_model_class.dart';
import 'package:pet_friend/model_class/bird_model_class.dart';
import 'package:pet_friend/model_class/cat_model_class.dart';

import '../../model_class/dog_model_class.dart';
import '../../model_class/food_model_class.dart';
import 'food_details_form.dart';

class AddProduct extends StatefulWidget {


   AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}
    List<String> categoryList=<String>["Select Category","pets","food","accessory"]; String categoryListFirstItem=categoryList[0];

   List<String> petsList=<String>["Select pet","bird","cat","dog"]; String petsListFirstItem=petsList[0];


class _AddProductState extends State<AddProduct> {

  /////////////////////////////////////////////////////////////////////////////////////
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController colorsController = TextEditingController();
  final TextEditingController talkController = TextEditingController();
  final TextEditingController flyController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController trainedController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    colorsController.dispose();
    talkController.dispose();
    flyController.dispose();
    ageController.dispose();
    quantityController.dispose();
    priceController.dispose();
    breedController.dispose();
    trainedController.dispose();
    super.dispose();
  }

  void clearConstructors(){
    nameController.clear();
    descriptionController.clear();
    colorsController.clear();
    talkController.clear();
    flyController.clear();
    ageController.clear();
    quantityController.clear();
    priceController.clear();
    breedController.clear();
    trainedController.clear();
  }


  List<String> _listOfColors = [];
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
                  /// drop down button for selecting product category SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        border:OutlineInputBorder()
                    ),
                    value: categoryListFirstItem,
                      validator: ((v){
                        if(v=="Select Category") return "select a valid option";
                         return null;
                      }),
                      items:categoryList.map((e) => DropdownMenuItem(child: Text(e),
                      value: e,)).toList() ,
                      onChanged:(v){

                        setState(() {
                          categoryListFirstItem=v.toString();
                        });
                      } ),
                  /// drop down button for selecting product category EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                  /// drop down button for selecting pets SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  if(categoryListFirstItem!="Select Category")
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          border:OutlineInputBorder()
                      ),
                      value: petsListFirstItem,
                      validator: ((v){
                        if(v=="Select Category") return "select a valid option";
                        return null;
                      }),
                      items:petsList.map((e) => DropdownMenuItem(child: Text(e),
                        value: e,)).toList() ,
                      onChanged:(v){

                        setState(() {
                          petsListFirstItem=v.toString();
                        });
                      } ),
                  /// drop down button for selecting pets EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE




                  if(categoryListFirstItem=="pets" && petsListFirstItem=="bird")
                    BirDetailsForm(
                        nameController: nameController,
                        colorsController: colorsController,
                        talkController: talkController,
                        flyController: flyController,
                        ageController: ageController,
                        priceController: priceController),

                if(categoryListFirstItem=="pets" && petsListFirstItem=="cat")
                  CatDetailsForm(
                      breedController: breedController,
                      colorsController: colorsController,
                      trainedController: trainedController,
                      ageController: ageController,
                      priceController: priceController),
                if(categoryListFirstItem=="pets" && petsListFirstItem=="dog")
                  DogDetailsForm(
                      breedController: breedController,
                      colorsController: colorsController,
                      trainedController: trainedController,
                      ageController: ageController,
                      priceController: priceController),

                if(categoryListFirstItem =="accessory" && petsListFirstItem != "Select pet")
                  AccessoriesForm(
                      nameController: nameController,
                      priceController: priceController,
                    descriptionController: descriptionController,
                  ),

                  if(categoryListFirstItem =="food" && petsListFirstItem != "Select pet")
                  FoodForm(
                      nameController: nameController,
                    descriptionController: descriptionController,
                  quantityController: quantityController,
                    priceController: priceController,
                  ),


                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                          _addStringToList();///might have problem
                          dynamic fireData;


                          if(categoryListFirstItem=="pets" && petsListFirstItem=="bird") {
                             fireData = BirdModelClass(
                              name: nameController.text.trim(),
                              colors: _listOfColors,
                              talk: talkController.text.trim(),
                              fly: flyController.text.trim(),
                              age: ageController.text.trim(),
                              price: double.parse(priceController.text.trim()),
                            );
                            fireData.category = categoryListFirstItem;
                            fireData.key=petsListFirstItem;
                          }



                          if(categoryListFirstItem=="pets" && petsListFirstItem=="cat"){
                            fireData=CatModelClass(
                              breed: breedController.text.trim(),
                              colors: _listOfColors,
                               trained: trainedController.text.trim(),
                              age: ageController.text.trim(),
                              price: double.parse(priceController.text.trim()),
                            );
                            fireData.category = categoryListFirstItem;
                            fireData.key=petsListFirstItem;



                          }
                          if(categoryListFirstItem=="pets" && petsListFirstItem=="dog"){
                            fireData=DogModelClass(
                              breed: breedController.text.trim(),
                              colors: _listOfColors,
                               trained: trainedController.text.trim(),
                              age: ageController.text.trim(),
                              price: double.parse(priceController.text.trim()),
                            );
                            fireData.category = categoryListFirstItem;
                            fireData.key=petsListFirstItem;
                          }

                          if(categoryListFirstItem=="accessory") {
                            fireData = AccessoryModelClass(
                              name: nameController.text.trim(),
                              description: descriptionController.text.trim(),
                              price: double.parse(priceController.text.trim()),
                            );
                            fireData.category=categoryListFirstItem;
                            fireData.key=petsListFirstItem;
                          }
                          if(categoryListFirstItem=="food") {
                            fireData = FoodModelClass(
                              name: nameController.text.trim(),
                              description: descriptionController.text.trim(),
                              quantity: quantityController.text.trim(),
                              price: double.parse(priceController.text.trim()),
                            );
                            fireData.category=categoryListFirstItem;
                            fireData.key=petsListFirstItem;
                          }
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return AddProductPic(fireData: fireData);}));

                          clearConstructors();
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
