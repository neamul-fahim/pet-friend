
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model_class/cart_model_class.dart';
import '../product_overview_screen/product_overview_screen.dart';
import '../provider/accessory_provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/food_provider.dart';

class Featured extends StatefulWidget {
  final dynamic products;
   final ScaffoldMessengerState scaffoldMessengerState;
  const Featured({Key? key, required this.scaffoldMessengerState, this.products}) : super(key: key);

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {

  List<String>featuredProduct=[
    'assets/car_pics/car1.jpg',
    'assets/car_pics/car2.jpg',
    'assets/car_pics/car3.jpg',
    'assets/car_pics/car4.jpg',
    'assets/car_pics/car5.jpg',
    'assets/car_pics/car6.jpg',
    'assets/car_pics/car7.jpg',
    'assets/car_pics/car8.jpg',
    'assets/car_pics/car9.jpg',
    'assets/car_pics/car10.jpg',];

  @override
  Widget build(BuildContext context) {
    double dynamicHeight = MediaQuery.of(context).size.height;
    double dynamicWidth = MediaQuery.of(context).size.width;
    //
    // double dynamicHeight =MediaQuery.of(context).size.height;
    // double dynamicWidth =MediaQuery.of(context).size.width;
    // bool once=true; bool loadedData=false;
    // bool _isMounted = false;
    //
    //
    // @override
    // void initState() {
    //   super.initState();
    //   _isMounted = true;
    // }
    //
    //
    // @override
    // void dispose() {
    //   _isMounted = false;
    //   super.dispose();
    // }
    //
    //
    //
    // final cats=Provider.of<CatProvider>(context);
    // final birds=Provider.of<BirdProvider>(context);
    // final dogs=Provider.of<DogProvider>(context);
    // final food=Provider.of<FoodProvider>(context);
    // final accessory=Provider.of<AccessoryProvider>(context);
    //
    // Future<void>getData()async {
    //   await cats.initializeCatList();
    //   await birds.initializeBirdList();
    //   await dogs.initializeDogList();
    //   await food.initializeFoodList();
    //   await accessory.initializeAccessoryList();
    //
    //
    //   if (_isMounted) {
    //     setState(() {
    //       once=false;
    //       loadedData=true;
    //     });
    //   }
    // }
    // if (once) getData();
    //
    // List <dynamic> products=[];
    //
    // products=[...birds.birdList,...cats.catList,...dogs.dogList,...food.foodList,...accessory.accessoryList];


    return Container(
      margin:EdgeInsets.only(top:10) ,
      padding:EdgeInsets.all(10),
      height:dynamicHeight*1.3,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              SizedBox(height: 20,),
              Text("Featured",
            style: TextStyle(color:Colors.red.shade900,fontSize:30 ,fontWeight:FontWeight.w600 ),),
              SizedBox(height: 20,),

          Expanded(
            child:GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemCount: 10, // Number of items in the grid
              itemBuilder: (context, index) {
                // Builder function to create each grid item
                return GrideElement(widget.products[index],dynamicHeight,dynamicWidth);
              },
            )
          ),
        ],
      ),
    );
  }






  GrideElement(dynamic products,dynamic dyHeight,dynamic dyWidth)
  {
    return
      Card(
        //height: dynamicHeight*0.02,
        // width: dynamicWidth*0.9,
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
                flex: 8,
                child: SizedBox(
                  width: double.infinity,


                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return ProductOverviewScreen(product:products);
                      }));
                    },
                    child:
                    Image.network(
                      products.imgURL[0],
                      fit: BoxFit.fill,
                    ),

                    // Container( ///pic container for network image
                    // //  color: Colors.blue,
                    //   height: dynamicHeight*0.15,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)),
                    //       image: DecorationImage(
                    //         image:NetworkImage(widget.pets.imgURL[0],),fit: BoxFit.fill,
                    //         //NetworkImage(pets.imgURL[0]),fit: BoxFit.fill,
                    //       )),),

                  ),
                ),
              ),

              SizedBox(height: 3.0),
              Expanded(
                flex: 2,
                child: FittedBox(
                  child: Text(
                    products.name,
                    textAlign: TextAlign.center, // Center the text within its space
                    style: TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Divider(height: 10,color: Colors.black,indent: 10,endIndent: 10),

              Expanded(
                flex: 3,
                child: FittedBox(

                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${products.price} tk",style: TextStyle(fontSize: 22,color: Colors.white),),
                        SizedBox(width: 16.0), // Add spacing between widgets if needed
                        IconButton(
                          onPressed: () {
                            print("***************************************************${products.firebasePath}************************");

                            if (FirebaseAuth.instance.currentUser == null) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Center(child: Text("Don't have an account"))),
                              );
                              return;
                            }

                            GetAndSetCartDataToFirebase().setCartDataToFirebase(products, true, widget.scaffoldMessengerState)
                                .then((value) {
                              // Perform actions after adding to cart if needed
                            });
                          },
                          icon: Icon(Icons.shopping_cart_checkout_outlined, size: 40,color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
}
