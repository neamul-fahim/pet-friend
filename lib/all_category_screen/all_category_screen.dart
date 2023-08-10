import 'package:flutter/material.dart';
import 'package:pet_friend/category_screens/accessory_category_screen.dart';
import 'package:pet_friend/category_screens/pets_category_screen.dart';
import 'package:provider/provider.dart';
import '../category_screens/food_category_screen.dart';
import '../provider/product_category_provider.dart';

class AllCategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productCat=Provider.of<ProductCategoryProvider>(context);
    productCat.initializeCategoryProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Colors.teal,
      ),
      body:
      GridView.builder(
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
              if(productCat.categoryData[index].name=="Pets")
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PetsCategoryScreen()));
              if(productCat.categoryData[index].name=="Food")
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodCategoryScreen()));
              if(productCat.categoryData[index].name=="Accessory")
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AccessoryCategoryScreen()));

            },

              child: CategoryCard(img: productCat.categoryData[index].imgUrl,name:productCat.categoryData[index].name ,));
        },
      ),
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

