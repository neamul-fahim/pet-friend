




import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_friend/model_class/cart_model_class.dart';
import 'package:provider/provider.dart';

import '../product_overview_screen/product_overview_screen.dart';
import '../provider/cart_provider.dart';
import 'Admin_product_overview_screen.dart';
import 'admin_product_screen.dart';

class AdminProductGridItem extends StatefulWidget {

  final dynamic products;

  AdminProductGridItem({Key? key,this.products}) : super(key: key);

  @override
  State<AdminProductGridItem> createState() => _AdminProductGridItemState();
}

    final _db=FirebaseFirestore.instance;




class _AdminProductGridItemState extends State<AdminProductGridItem> {

     bool deleting=false;


  late ScaffoldMessengerState scaffoldMessengerState;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    scaffoldMessengerState=ScaffoldMessenger.of(context);
  }
  var clickAbsorb=false;

  void sendToFirebase(dynamic pets){
    CartModelClass(firebasePath: pets.firebasePath, );
  }

  @override
  Widget build(BuildContext context) {

    var ImageType="asset";
    var temp=widget.products.imgURL[0];
    if(temp[0]=="h" && temp[1]=="t" && temp[2]=="t" && temp[3]=="p") ImageType="network";

    var cart=Provider.of<CartProvider>(context);
    double dynamicHeight =MediaQuery.of(context).size.height;
    double dynamicWidth =MediaQuery.of(context).size.width;





    return
      Card(

        shadowColor: Colors.teal,
        elevation: 30,
        color: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),

          child: Column(
            mainAxisSize: MainAxisSize.min, // Use MainAxisSize.min to take the minimum height required
            children: [
              // widget.pets.imgURL[0].isEmpty?const CircularProgressIndicator():
              // ImageType=="network"?
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return AdminProductOverviewScreen(product:widget.products);
                      }));
                    },
                    child:
                    Image.network(
                      widget.products.imgURL[0],
                      fit: BoxFit.fill,
                    ),

                  ),
                ),
              ),

              SizedBox(height: 8.0),
              Expanded(
                flex: 1,
                child: Text(
                  widget.products.name,
                  textAlign: TextAlign.center, // Center the text within its space
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),

              Divider(height: 8,color: Colors.black,indent: 10,endIndent: 10,thickness: 0.5),

             Expanded(
               flex: 2,
               child: IconButton(onPressed: ()async{
                 setState(() {
                   deleting=true;
                 });
                 int lastSlashIndex = widget.products.firebasePath.lastIndexOf('/');
                 String collectionPath = widget.products.firebasePath.substring(0, lastSlashIndex);
                 String documentId = widget.products.firebasePath.substring(lastSlashIndex + 1);


                 await _db.collection(collectionPath).doc(documentId).delete();
                 Fluttertoast.showToast(msg: "Product deleted from database");
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                     AdminProductScreen(category: widget.products.category.toString().toLowerCase())));

               },
                   icon: deleting==true?Center(child: CircularProgressIndicator()):Icon(Icons.delete_forever_rounded,color: Colors.red.shade500,size: 30,)),
             )
            ],
          ),
        ),
      );
  }
}

