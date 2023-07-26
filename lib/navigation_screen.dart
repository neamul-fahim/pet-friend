



import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_friend/google_map/google_map.dart';
import 'package:pet_friend/model_class/user_data_model.dart';
import 'package:pet_friend/my_home_page/my_home_page.dart';
import 'package:pet_friend/user_profile_screen/user_profile_screen.dart';

import '../bottom_navigation_search_page.dart';
import '../drawer/drawer_structure.dart';
import '../featured/featured.dart';
import '../flash_sale/flash_sale.dart';
import '../image_slider/image_slider.dart';
import '../product_categories/product_categories.dart';

List<IconData> iconList = [
  Icons.home,
  Icons.map_rounded,
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


  final List<Widget> _screens = [
    MyHomePage(),
    SearchPlacesScreen(),
    // Add more screens as per your requirement
  ];

  @override
  Widget build(BuildContext context) {
    // Provider.of<MyHomePageProvider>(context, listen: false)
    //     .initializemyHomePageModelClass();

    double dynamicHeight = MediaQuery.of(context).size.height;
    double dynamicWidth = MediaQuery.of(context).size.width;

    ///TO get out of the app (pop up massage)  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    return Scaffold(
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


      body:_screens[_bottomNavIndex],
    );
  }
}
