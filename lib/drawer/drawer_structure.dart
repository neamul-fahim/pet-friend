


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_friend/admin_panel/admin_panel_screen.dart';
import 'package:pet_friend/pet_diseases_remedy_screen/pet_diseases_remedy_screen.dart';
import 'package:pet_friend/pet_trainer_and_doctor/pet_trainer_and_doctor.dart';
import 'package:provider/provider.dart';
import '../admin_panel/add_product/add_product_pic.dart';
import '../cart/cart_screen.dart';
import '../google_map/google_map.dart';
import '../provider/app_drawer_provider.dart';
import '../signin_login/login.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({Key? key,}) : super(key: key);

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}


   // File ? imageFile;
   // File ? finalImageFile;




class _CustomAppDrawerState extends State<CustomAppDrawer> {

  final _db=FirebaseFirestore.instance;
  var name="Name";
  String imgURL="";
  bool once=false;


  @override
  Widget build(BuildContext context) {
    // user=FirebaseAuth.instance.currentUser!.uid;

    // print("UUUUUUUUUUUUUUUUUUUUUUU111111111111111111111111111111111111111111111111UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
    // print("UUUUUUUUUUUUUUUUUUUUUUUUUUUU${user.toString()}UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");

    Future<void> fun() async{
      var t;
      ///profile Pic download link SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
       try {
         var fireStorePath = firebaseStorage
             .child("pet_friend").child("users").child(
             FirebaseAuth.instance.currentUser!.uid).child("pics");
         imgURL = await fireStorePath.getDownloadURL();

         ///profile Pic download link EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

         final tempJson = await _db.collection("users").doc(
             FirebaseAuth.instance.currentUser!.uid).get();
          t = tempJson.data();
       }catch(e){
         Fluttertoast.showToast(msg: e.toString());
       }
      setState(() {

        once=true;
        name= t != null ? t["name"]:"Name";
      });
    }
    if( FirebaseAuth.instance.currentUser!=null && !once) fun();

    //Provider.of<AppDrawerProvider>(context,listen: false).initializeAppDrawerModelClass();

    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;
    //final File imageFile;
    //XFile ? pick;
   // var pickedImage;
    return
           Consumer <AppDrawerProvider>(builder: (context,appDrawerProvider,index)
          {
            return Container(
              height: dynamicHeight,
              width: dynamicWidth*2/3,
              decoration: BoxDecoration(

                color: Colors.teal.shade300,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 85.0),
                child: SingleChildScrollView(
                  child: Column(
                    children:[

                      /// Profile pic SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                      Container(
                        height: dynamicWidth*0.3,
                        width: dynamicWidth*0.3,
                        ///child: finalImageFile==null?

                        child: imgURL.isEmpty?Image.asset("assets/dummy_pic/profilePic.webp",fit: BoxFit.fill,)
                            :Image.network(imgURL,fit: BoxFit.fill,),
                            ///:Image.file(finalImageFile!,fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      /// Profile pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                      Text(name, //appDrawerProvider.appDrawerModelClass.profileName.toString(),
                          style:TextStyle(fontSize: 20,fontWeight:FontWeight.w400 ) ),///User name


                     const SizedBox(
                        height: 60,
                      ),
                      /// Drawer options SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                      if(FirebaseAuth.instance.currentUser!=null)drawerProperty(Icons.shopping_cart, "Cart", context, () => Cart()),
                      drawerProperty(Icons.insert_drive_file_outlined, 'Pet trainer & doctor',context,()=>PetTrainerAndDoctor()),
                      drawerProperty(Icons.medical_information_rounded, 'Pet disease and remedy',context,()=>PetInfoScreen()),
                      drawerProperty(Icons.map, 'Find Pet Care Home',context,()=>SearchPlacesScreen()),

                      //drawerProperty(Icons.cloud_rounded, 'Weather',context,()=>Weather()),
                     const Divider(
                        //color: Colors.black,
                        thickness: 1,
                        height: 20,
                          indent: 15,
                        endIndent: 15,
                      ),
                      drawerProperty(Icons.cloud_rounded, 'Login',context,()=>LogIN()),
                    if(FirebaseAuth.instance.currentUser != null) drawerProperty(Icons.logout_rounded, 'Logout',context,()=>LogIN()),
                      drawerProperty(Icons.admin_panel_settings, "Admin Panel", context, () => AdminPanel())

                      /// Drawer options EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                    ],
                  ),
                ),
              ),
            );

          }

      );



  }

 //  XFile? imageXFile;
 // /// File? finalImageFile;
 //  /// File? tempImage;
 //  Future SelectImage(source)async{
 //    final ImagePicker _picker=ImagePicker();
 //    imageXFile= await _picker.pickImage(source: source);
 //
 //    if (imageXFile==null) return;
 //     /// tempImage=File(imageXFile!.path);
 //    setState(() {
 //     /// finalImageFile=tempImage;
 //    });
 //     //return imageFile;
 //   // final XFile? video= await _picker.pickVideo(source: source);
 //
 //  }


  /// Function to determine what action is needed to perform when drawer option is pressed   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
  Container drawerProperty(IconData drawerOptionIcon,String drawerOptionName,BuildContext context,Widget Function() className){
    return Container(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async{
              if(drawerOptionIcon==Icons.logout_rounded)///for logout
              {
                 FirebaseAuth.instance.signOut().then((value) {
                   Fluttertoast.showToast(msg: "loged out");

                   //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("loge out")));


                   Navigator.pop(context); ///to close drawer
                     print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");




                  //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  //    return className();///test purpose
                  //  }
                  //  ));

                }).catchError((error){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
                });

              }
              else ///for other drawer options
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return className();///test purpose
                }
                ));

            },
            child: Row(
              children: [
                Icon(drawerOptionIcon,color: Colors.black,size: 28),
                SizedBox(
                  width: 10,
                ),
                Text(drawerOptionName,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400

                ),),
              ],
            ),
          ),
        )
    );
  }
/// Function to determine what action is needed to perform when drawer option is pressed EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

}



// void pageRout(BuildContext context,className){
   // Navigator.push(context, MaterialPageRoute(builder: (context)=>className));
   //
   // }