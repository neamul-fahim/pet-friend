
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/model_class/bird_model_class.dart';

class AddProduct extends StatefulWidget {


   AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}
    List<String> proList=<String>["select","bird","dog","cat","food","accessory"];
   final fireStore=FirebaseFirestore.instance;
class _AddProductState extends State<AddProduct> {

  /////////////////////////////////////////////////////////////////////////////////////
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorsController = TextEditingController();
  final TextEditingController _talkController = TextEditingController();
  final TextEditingController _flyController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> _listOfColors = [];

  @override
  void dispose() {
    _nameController.dispose();
    _colorsController.dispose();
    _talkController.dispose();
    _flyController.dispose();
    _ageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void clearConstructors(){
    _nameController.clear();
    _colorsController.clear();
    _talkController.clear();
    _flyController.clear();
    _ageController.clear();
    _priceController.clear();
  }

  void _addStringToList() {
    setState(() {
      var temp=_colorsController.text;
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
            padding: const EdgeInsets.only(top: 150.0,left: 50,right: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  DropdownButtonFormField(

                    decoration: InputDecoration(
                        border:OutlineInputBorder()
                    ),
                    value: firstItem,
                      validator: ((v){
                        if(v=="select") return "select a valid option";
                         return null;
                      }),
                      items:proList.map((e) => DropdownMenuItem(child: Text(e),
                      value: e,)).toList() ,
                      onChanged:(v){

                        setState(() {
                          firstItem=v.toString();
                        });
                      } ),
                  SizedBox(height: 16),

                  TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                  SizedBox(height: 16),

                  /////////////////////////////////////////////////////////////////////////////////
                  TextFormField(
                    controller: _colorsController,
                    decoration: InputDecoration(
                      labelText: 'Enter colors using comma',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter colors';
                      }
                      return null;
                    },
                  ),

                  //////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 16),
                TextFormField(
                  controller: _talkController,
                  decoration: InputDecoration(
                    labelText: 'YES if can talk or NO otherwise',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide info if can talk or not';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _flyController,
                  decoration: InputDecoration(
                    labelText: 'YES if can fly or NO otherwise',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide info if can fly';
                    }
                    return null;
                  },
                ),
                  SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age Ex: 1 year 6 months',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide Age';
                    }
                    return null;
                  },
                ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide price';
                      }
                      return null;
                    },
                  ),
                  // SizedBox(height: 16),
                  // TextFormField(  ///this field should be filled automatically from server after adding image
                  //   decoration: InputDecoration(
                  //     labelText: 'Image URL',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   validator: (value) {
                  //     // if (value!.isEmpty) {
                  //     //   return 'Please provide image URL';
                  //     // }
                  //     return null;
                  //   },
                  // ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                        _addStringToList();///might have problem
                     var docID= await fireStore.collection("products").doc("pets").collection(firstItem).doc();
                          docID.set(

                              BirdModelClass(
                             key: firstItem,
                            id: docID.id,
                          name: _nameController.text,
                         colors:_listOfColors,
                        talk: _talkController.text,
                        fly: _flyController.text,
                        age: _ageController.text,
                        price: double.parse(_priceController.text),
                      ).toFirebase(),SetOptions(merge: true)).then((value){
                       // print(value.);

                            firstItem=proList[0];
                         clearConstructors();
                         setState(() {
                         });
                            const ScaffoldMessenger(child: Text("data sent to server"),);
                          }).catchError((err){
                        ScaffoldMessenger(child: Text(err.toString()),);///err.message !!!!!
                      });
                      // Do something when the form is submitted
                    }
                  },
                  child: Text('Submit'),
                ),


                ],
              ),
            ),
          ),
        ),
    );
  }
}
