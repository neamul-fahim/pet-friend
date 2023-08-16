



import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_friend/all_category_screen/all_category_screen.dart';
import 'package:pet_friend/google_map/google_map.dart';
import 'package:pet_friend/model_class/user_data_model.dart';
import 'package:pet_friend/my_home_page/my_home_page.dart';
import 'package:pet_friend/pet_trainer_and_doctor/pet_trainer_and_doctor.dart';
import 'package:pet_friend/user_profile_screen/user_profile_screen.dart';
import '../bottom_navigation_search_page.dart';
import '../drawer/drawer_structure.dart';
import '../featured/featured.dart';
import '../flash_sale/flash_sale.dart';
import '../image_slider/image_slider.dart';
import '../product_categories/product_categories.dart';
import 'cart/cart_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



List<IconData> iconList = [
  Icons.home_rounded,
  Icons.category_rounded,
  kIsWeb?Icons.insert_drive_file_outlined:Icons.map_rounded,
  Icons.shopping_cart_rounded
];
var _bottomNavIndex = 0;

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

String appTitle = 'Pet Friend';

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    double dynamicHeight = MediaQuery.of(context).size.height;
    double dynamicWidth = MediaQuery.of(context).size.width;

    ///TO get out of the app (pop up massage)  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    return WillPopScope(
        onWillPop: () async {
      if(_scaffoldKey.currentState != null && _scaffoldKey.currentState!.isDrawerOpen) {
        return true;
      }
      bool willpop = false;
      await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Alert'),
        content: Text('Do You Want To Exit?'),
        actions: [
          ElevatedButton(
              onPressed: () {
                willpop = true;
                Navigator.pop(context);
              },
              child: Text('Yes')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No')),
        ],
      ));
      return willpop;
    },
    ///TO get out of the app (pop up massage)  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


      child:Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Container(
      //     child: Text(
      //       appTitle,
      //       style: TextStyle(fontSize: 25),
      //     ),
      //   ),
      //   backgroundColor: Colors.teal.shade400,
      // ),

      ///Bottom navigation bar SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.black,
        child: Icon(
          Icons.account_circle_rounded,
          size: 35,
        ),
        onPressed: () async{
          if(FirebaseAuth.instance.currentUser!=null) {
            var userData = await UserDataRepository().getFireData();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                UserProfileScreen(uid: userData.uid,
                    name: userData.name,
                    phoneNumber: userData.phone,
                    email: userData.email,
                    address: userData.address,
                    profilePicture: userData.profilePicURL)));

          }
          else {
            Fluttertoast.showToast(msg: "Log into your account");
          }

        },
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.teal,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),

      ///Bottom navigation bar EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


      body:
      Container(
        child: _bottomNavIndex == 0? MyHomePage():
               _bottomNavIndex == 1? AllCategoryScreen():_bottomNavIndex==2 && kIsWeb?PetTrainerAndDoctor():
               _bottomNavIndex==2 ?SearchPlacesScreen():Cart(),
      )
      )
    );
  }
}
