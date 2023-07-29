

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_friend/google_map/google_map.dart';
import 'package:pet_friend/model_class/user_data_model.dart';
import 'package:pet_friend/user_profile_screen/user_profile_screen.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation_search_page.dart';
import '../drawer/drawer_structure.dart';
import '../featured/featured.dart';
import '../flash_sale/flash_sale.dart';
import '../image_slider/image_slider.dart';
import '../product_categories/product_categories.dart';
import '../provider/accessory_provider.dart';
import '../provider/bird_provider.dart';
import '../provider/cat_provider.dart';
import '../provider/dog_provider.dart';
import '../provider/food_provider.dart';

List<IconData> iconList = [
  Icons.home,
  Icons.map_rounded,
];
var _bottomNavIndex = 0;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

      String appTitle = 'Pet Friend';

class _MyHomePageState extends State<MyHomePage> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   bool once=true; bool loadedData=false;
   bool _isMounted = false;

  @override
  Widget build(BuildContext context) {

    late ScaffoldMessengerState scaffoldMessengerState;
    scaffoldMessengerState=ScaffoldMessenger.of(context);

    double dynamicHeight = MediaQuery.of(context).size.height;
    double dynamicWidth = MediaQuery.of(context).size.width;





    @override
    void initState() {
      super.initState();
      _isMounted = true;
    }


    @override
    void dispose() {
      _isMounted = false;
      super.dispose();
    }



    final cats=Provider.of<CatProvider>(context);
    final birds=Provider.of<BirdProvider>(context);
    final dogs=Provider.of<DogProvider>(context);
    final food=Provider.of<FoodProvider>(context);
    final accessory=Provider.of<AccessoryProvider>(context);

    Future<void>getData()async {
      await cats.initializeCatList();
      await birds.initializeBirdList();
      await dogs.initializeDogList();
      await food.initializeFoodList();
      await accessory.initializeAccessoryList();

   print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX11111111111111111111111111XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

        setState(() {
          print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX22222222222222222222222222222222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
          once=false;
          loadedData=true;
        });

    }
    if (once) getData();

    List <dynamic> products=[];

    products=[...birds.birdList,...cats.catList,...dogs.dogList,...food.foodList,...accessory.accessoryList];



    ///TO get out of the app (pop up massage)  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    return Scaffold(
        key: _scaffoldKey,

        endDrawer: CustomAppDrawer(),

        appBar: AppBar(
          centerTitle: true,
          title: Container(
            child: Text(
              appTitle,
              style: TextStyle(fontSize: 25),
            ),
          ),
          backgroundColor: Colors.teal.shade400,
        ),

        ///Bottom navigation bar SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.teal,
        //   foregroundColor: Colors.black,
        //   child: Icon(
        //     Icons.account_circle_rounded,
        //     size: 35,
        //   ),
        //   onPressed: () async{
        //      if(FirebaseAuth.instance.currentUser!=null) {
        //        var userData = await UserDataRepository().getFireData();
        //        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        //            UserProfileScreen(uid: userData.uid,
        //            name: userData.name,
        //            phoneNumber: userData.phone,
        //            email: userData.email,
        //            address: userData.address,
        //            profilePicture: userData.profilePicURL)));
        //
        //      }
        //      else {
        //        Fluttertoast.showToast(msg: "Log into your account");
        //      }
        //
        //       },
        //   //params
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //   backgroundColor: Colors.teal,
        //   icons: iconList,
        //   activeIndex: _bottomNavIndex,
        //   gapLocation: GapLocation.center,
        //   notchSmoothness: NotchSmoothness.smoothEdge,
        //   onTap: (index) => setState(() => _bottomNavIndex = index),
        // ),

        ///Bottom navigation bar EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSlider(),
              ProductCategories(),
              if(loadedData==true) FlashSale(products: products),

              if(loadedData==true)Featured(scaffoldMessengerState:scaffoldMessengerState,products:products ),

              // if (_bottomNavIndex == 0) MyHomePage(),
              // if (_bottomNavIndex == 1) SearchPlacesScreen(),
            ],
          ),
        ),

    );
  }
}
