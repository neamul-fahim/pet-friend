

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/product_categories/product_category_pic_and_name.dart';
import 'package:provider/provider.dart';

import '../pets_category_screen/pets_category_screen.dart';
import '../provider/product_category_provider.dart';
import 'custom_circle_container.dart';

class ProductCategories extends StatefulWidget {



   const ProductCategories({Key? key,

  }) : super(key: key);

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

  ProductCatPicAndName  productCatPicAndName=ProductCatPicAndName();
  // int i=0;


  class _ProductCategoriesState extends State<ProductCategories> {
  @override
  Widget build(BuildContext context) {

      final productCat=Provider.of<ProductCategoryProvider>(context);
      productCat.initializeCategoryProvider();

    double dynamicHeight =MediaQuery.of(context).size.height;
    double dynamicWidth =MediaQuery.of(context).size.width;


      ///  main Container  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    return Padding(
      padding: const EdgeInsets.only(top:8.0,left: 2,right: 2),
      child: Container(
        decoration: BoxDecoration(
          //color:Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        ///  main Container  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

        /// Teal Color Container And Categories  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
        child: Stack(
          children: [
            Container(  /// Teal  Color container
              height: dynamicHeight*0.12,
              //width: dynamicWidth,
              decoration: BoxDecoration(
                color:Colors.teal,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
              ),
            ),
            Padding(   /// Categories
              padding: const EdgeInsets.only(left: 15,right: 15,top: 35),
              child: PhysicalModel(
                borderRadius:BorderRadius.circular(30),
              color: Colors.grey.shade200,
              shadowColor: Colors.black,
              shape: BoxShape.rectangle,
              elevation: 20,
              child: Stack(
               // alignment: AlignmentDirectional.topStart,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                         const  Spacer(),
                             for(int i=0;i<productCat.categoryData.length;i++)
                          InkWell(
                            onTap: (){
                              if(productCat.categoryData[i].name=='Pets')
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return PetsCategoryScreen();
                              }));

                            },
                            child: CustomCircleContainer(
                              productPic:productCat.categoryData[i].imgUrl,
                              productDescription:productCat.categoryData[i].name,
                              //index: i,
                            ),
                          ),
                         const Spacer(),

                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Spacer(),
                      //     for(int i=5;i<=7;i++)
                      //       CustomCircleContainer(productPic:productCat.ProductCategory[i].imgUrl,
                      //         productDescription:productCat.ProductCategory[i].name,
                      //         //index: i,
                      //       ),
                      //     Spacer(),
                      //
                      //   ],
                      // ),

                    ],
                  )

                ],
              ),
          ),
            ),
        ]

              /// Teal Color Container And Categories  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        ),
      ),
    );
  }
}

