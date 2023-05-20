





    import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_friend/admin_panel/admin_panel.dart';
import 'package:pet_friend/provider/app_drawer_provider.dart';
import 'package:pet_friend/provider/bird_provider.dart';
import 'package:pet_friend/provider/cart_provider.dart';
import 'package:pet_friend/provider/cat_provider.dart';
import 'package:pet_friend/provider/dog_provider.dart';
import 'package:pet_friend/provider/filter_provider.dart';
import 'package:pet_friend/provider/my_home_page_provider.dart';
import 'package:pet_friend/provider/product_category_provider.dart';
import 'package:pet_friend/signin_login/login.dart';
import 'package:pet_friend/test_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'my_home_page/my_home_page.dart';

Future <void> main() async{
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
       );
  runApp(
      MultiProvider(
         providers: [
        //ChangeNotifierProvider<MyHomePageProvider>(create: (_)=>MyHomePageProvider()),
        ChangeNotifierProvider<AppDrawerProvider>(create: (_)=>AppDrawerProvider()),
        ChangeNotifierProvider<WeatherProvider>(create: (_)=>WeatherProvider()),
        ChangeNotifierProvider<BirdProvider>(create: (_)=>BirdProvider()),
        ChangeNotifierProvider<CatProvider>(create: (_)=>CatProvider()),
        ChangeNotifierProvider<DogProvider>(create: (_)=>DogProvider()),
        ChangeNotifierProvider<ProductCategoryProvider>(create: (_)=>ProductCategoryProvider()),
        ChangeNotifierProvider<FilterProvider>(create: (_)=>FilterProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_)=>CartProvider()),

    ],
       child: MyApp())
  );
}



class ProductCategoryProviderProvider {
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // final birds=Provider.of<BirdProvider>(context);
    // final cats=Provider.of<CatProvider>(context);
    // final dogs=Provider.of<DogProvider>(context);
    //
    // birds.initializeBirdList();
    // cats.initializeCatList();
    // dogs.initializeDogList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: MyHomePage(),
       //TestScreen(),
       //FirebaseAuth.instance.currentUser==null? LogIN():MyHomePage() ///comment out if you want to show the login page on start
    );
  }
}






