
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {


   AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}
    List<String> proList=<String>["select,","birds","dogs","cats"];

class _AddProductState extends State<AddProduct> {

  /////////////////////////////////////////////////////////////////////////////////////
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _listOfStrings = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _addStringToList() {
    setState(() {
      var temp=_textEditingController.text;
      var temp1=temp.split(" ");
      _listOfStrings+=temp1;
      _textEditingController.clear();
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border:OutlineInputBorder()
                  ),
                  value: firstItem,
                    items:proList.map((e) => DropdownMenuItem(child: Text(e),
                    value: e,)).toList() ,
                    onChanged:(v){

                      setState(() {
                        firstItem=v.toString();
                      });
                    } ),
                SizedBox(height: 16),

                TextFormField(
               // controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
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
              TextFormField(
               // controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
               // controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Do something when the form is submitted
                  }
                },
                child: Text('Submit'),
              ),

               /////////////////////////////////////////////////////////////////////////////////
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Enter a string',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _addStringToList,
                  child: Text('Add to list'),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 200,
                  child: ListView.builder(
                    //shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: _listOfStrings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_listOfStrings[index]),
                      );
                    },
                  ),
                ),

                //////////////////////////////////////////////////////////////////////////////////
              ],
            ),
          ),
        ),
    );
  }
}
