

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../bottom_navigation_search_page.dart';
import '../drawer/drawer_structure.dart';
import '../featured/featured.dart';
import '../flash_sale/flash_sale.dart';
import '../image_slider/image_slider.dart';
import '../product_categories/product_categories.dart';

List<IconData> iconList = [
  Icons.home,
  Icons.category_rounded,
  Icons.chat_bubble_rounded,
  Icons.account_circle_rounded,
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

  @override
  Widget build(BuildContext context) {
    // Provider.of<MyHomePageProvider>(context, listen: false)
    //     .initializemyHomePageModelClass();

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

      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomAppDrawer(),

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.black,
          child: Icon(
            Icons.search_rounded,
            size: 35,
          ),
          onPressed: () {
            setState(() {
              BottomNavigationSearch();
            });
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


        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSlider(),
              ProductCategories(
              ),
              FlashSale(),

              const Featured(),
              Container(
                color: Colors.red,
                height: dynamicHeight*0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
