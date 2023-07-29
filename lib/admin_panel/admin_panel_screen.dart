import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/admin_panel/add_product/add_product_details.dart';
import 'package:pet_friend/admin_panel/add_product/add_product_pic.dart';
import 'package:pet_friend/admin_panel/admin_drawer.dart';
import 'package:pet_friend/admin_panel/admin_product_screen.dart';
import 'package:pet_friend/model_class/app_drawer_model_class.dart';
import 'package:provider/provider.dart';

import '../category_screens/accessory_category_screen.dart';
import '../category_screens/food_category_screen.dart';
import '../category_screens/pets_category_screen.dart';
import '../provider/product_category_provider.dart';

   // var db;
   // bool once=true;


  class AdminPanel extends StatefulWidget {
    const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
    @override
    Widget build(BuildContext context) {

      final productCat=Provider.of<ProductCategoryProvider>(context);
      productCat.initializeCategoryProvider();

      // Future<void> fun()async {
      //   var name = "pets";
      //   var name1 = "bird";
      //   var name2 = "ZkWIpxF8D3A1dk7Oj2aq";
      //   var path = "products/$name/$name1/$name2";
      //
      //   db = await FirebaseFirestore.instance.doc(path).get();
      //   once=false;
      //   setState(() {
      //   });
      // }
      // if(once) fun();
      var dSize=MediaQuery.of(context).size;

      return Scaffold(
        appBar: AppBar(
          title: Text("Admin panel"),
          backgroundColor: Colors.teal,
        ),
        endDrawer:AdminDrawer(),
        body:      GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: MediaQuery.of(context).devicePixelRatio/2.6
          ),
          itemCount: productCat.categoryData.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        AdminProductScreen(category: productCat.categoryData[index].name.toLowerCase())));


                },

                child: CategoryCard(img: productCat.categoryData[index].imgUrl,name:productCat.categoryData[index].name ,));
          },
        ),

         // child: Text(db["price"].toString()),
      );
    }
}



class CategoryCard extends StatelessWidget {
  final String img;
  final String name;

  CategoryCard({
    required this.img,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.teal,
      elevation: 30,
      color: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              flex: 2,
              child: Text(
                name,
                textAlign: TextAlign.center, // Center the text within its space
                style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

