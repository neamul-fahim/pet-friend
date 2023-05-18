

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_friend/admin_panel/admin_panel.dart';
import 'package:provider/provider.dart';

import '../cart/cart_screen.dart';
import '../my_home_page/my_home_page.dart';
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
  @override
  Widget build(BuildContext context) {

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
                      InkWell(
                        onTap: (){
                         SelectImage(ImageSource.gallery);
                        },
                        child:
                        Container(
                          height: dynamicWidth*0.3,
                          width: dynamicWidth*0.3,
                          ///child: finalImageFile==null?

                          child:Image.asset("assets/car_pics/car2.jpg",fit: BoxFit.cover,),
                              ///:Image.file(finalImageFile!,fit: BoxFit.cover,),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        //     :Container(
                        //   height: dynamicWidth*0.18,
                        //   width: dynamicWidth*0.18,
                        //   child:Image.file(finalImageFile!),
                        //   decoration: BoxDecoration(
                        //       color: Colors.black,
                        //       borderRadius: BorderRadius.circular(30),
                        //   ),
                      ),
                      /// Profile pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                      Text("Name", //appDrawerProvider.appDrawerModelClass.profileName.toString(),
                          style:TextStyle(fontSize: 20,fontWeight:FontWeight.w400 ) ),///User name


                     const SizedBox(
                        height: 60,
                      ),
                      /// Drawer options SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                      drawerProperty(Icons.shopping_cart, "Cart", context, () => Cart()),
                      drawerProperty(Icons.home_rounded, 'Home',context,()=>MyHomePage()),
                      drawerProperty(Icons.add_circle, 'Add Post',context,()=>MyHomePage()),
                      drawerProperty(Icons.notifications_active, 'Notification',context,()=>MyHomePage()),
                      //drawerProperty(Icons.cloud_rounded, 'Weather',context,()=>Weather()),
                     const Divider(
                        //color: Colors.black,
                        thickness: 1,
                        height: 20,
                          indent: 15,
                        endIndent: 15,
                      ),
                      drawerProperty(Icons.cloud_rounded, 'Login',context,()=>LogIN()),
                     drawerProperty(Icons.logout_rounded, 'Logout',context,()=>LogIN()),
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
  XFile? imageXFile;
 /// File? finalImageFile;
  /// File? tempImage;
  Future SelectImage(source)async{
    final ImagePicker _picker=ImagePicker();
    imageXFile= await _picker.pickImage(source: source);

    if (imageXFile==null) return;
     /// tempImage=File(imageXFile!.path);
    setState(() {
     /// finalImageFile=tempImage;
    });
     //return imageFile;
   // final XFile? video= await _picker.pickVideo(source: source);

  }
}

       /// Function to determine what action is needed to perform when drawer option is pressed   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
 Container drawerProperty(IconData drawerOptionIcon,String drawerOptionName,BuildContext context,Widget Function() className){
  return Container(
    child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async{
          if(drawerOptionIcon==Icons.logout_rounded)///for logout
            {
              await FirebaseAuth.instance.signOut().then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("log out")));
               // Scaffold.of(context).showBottomSheet((context) => Text("log out"));
               // Navigator.popUntil(context, (route) => false);
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return className();///test purpose
                }
                ));
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
   // void pageRout(BuildContext context,className){
   // Navigator.push(context, MaterialPageRoute(builder: (context)=>className));
   //
   // }