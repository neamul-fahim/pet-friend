
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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


        setState(() {
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

        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSlider(),
              ProductCategories(),
              if(loadedData==true) FlashSale(products: products),
              if(loadedData==true)Featured(scaffoldMessengerState:scaffoldMessengerState,products:products ),
            ],
          ),
        ),

    );
  }
}
