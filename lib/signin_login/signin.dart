





import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model_class/user_data_model.dart';
import 'custom_text_form_field.dart';
import 'login.dart';

class SignIN extends StatefulWidget {
  const SignIN({Key? key}) : super(key: key);

  @override
  State<SignIN> createState() => _SignINState();
}

 /// FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  GlobalKey<FormState> _signinKey= GlobalKey<FormState>();
  TextEditingController signinNameController=TextEditingController();
  TextEditingController signinPhoneNumberController=TextEditingController();
  TextEditingController signinEmailController=TextEditingController();
  TextEditingController signinPassController=TextEditingController();
  TextEditingController signinConfirmPassController=TextEditingController();


class _SignINState extends State<SignIN> {
  @override
  Widget build(BuildContext context) {

    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;


    return
      Scaffold(
      body: Form(
        key:_signinKey ,
        child: Column(
          children: [

            ///  Page title SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            Padding(
              padding: const EdgeInsets.only(top:30,bottom: 0,right: 0,left:0 ),
              child: Text("SIGNIN",style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize:35
              ),),
            ),
            ///  Page title EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

            SizedBox(
              height: 30,
            ),

            /// Name field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

            CustomTextField(
              textController: signinNameController,
              ErrorMsg: "This field can't be empty",
              HintText: "Enter your name",
              LabelText:  "Name",
              fieldIcon: Icons.person,
              obscurePass: false,),

            /// Name field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


            /// Phone number field SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            CustomTextField(
              textController: signinPhoneNumberController,
              ErrorMsg: "This field can't be empty",
              HintText: "Enter your phone number",
              LabelText:  "Phone number",
              fieldIcon: Icons.phone,
              obscurePass: false,),
            /// Phone number field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


            /// Email field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            CustomTextField(
                textController: signinEmailController,
                ErrorMsg: "This field can't be empty",
                HintText: "Enter your email",
                LabelText:  "Email",
                fieldIcon: Icons.email_rounded,
                obscurePass: false,),

            /// Email field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

            ///Password field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            CustomTextField(
                textController: signinPassController,
                ErrorMsg: "This field can't be empty",
                HintText: "Enter your password",
                LabelText:  "Password",
                fieldIcon: Icons.shield,
                obscurePass: true,),

            ///Password field   EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

            ///Confirm password field   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            CustomTextField(
                textController: signinConfirmPassController,
                ErrorMsg: "This field can't be empty",
                HintText: "Retype your password",
                LabelText:  "Confirm password",
                fieldIcon: Icons.shield,
                obscurePass: true,),

            ///Confirm password field  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

            /// Signin button  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            Padding(
              padding: const EdgeInsets.only(left: 0,right:0 ,top: 2,bottom:0 ),
              child: Container(
                height: dynamicHeight*0.06,
                width: dynamicWidth*0.4,


                child: ElevatedButton(

                    onPressed:() {
                       if(_signinKey.currentState!.validate())
                         {
                           fireBaseSignin(signinEmailController.text,signinPassController.text,context);
                         }
                    },
                    child: Text("SIGNIN")),
              ),
            ),

                       /// Signin button EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE



            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  /// Asking if the user have an existing account  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  Text("Have an account?",style: TextStyle(
                    color: Colors.deepOrangeAccent,),
                  ),
                  /// Asking if the user have an existing account  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                      /// Goto login page if have an account  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  InkWell(
                      onTap: (){
                        Navigator.pop(context,MaterialPageRoute(builder: (context)=>LogIN()));

                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color: Colors.deepOrangeAccent,
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("LOGIN"),
                          )
                      )
                  ),

                  /// Goto login page if have an account  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
                    ///To signup using FirebaseAuth SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
         void fireBaseSignin(String email,String password,BuildContext context)async {

  // await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value){
  //
  //   Fluttertoast.showToast(msg: "Login successful");
  //      saveUserData();///saving user data
  //   loginEmailController.text=signinEmailController.text;///if signup is successful the login page will auto fill with signup values
  //   loginPassController.text=signinPassController.text;
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIN()));
  // }).catchError((error) {
  //   Fluttertoast.showToast(timeInSecForIosWeb: 3,msg: error.message);///Here (.message) is a firebase defined message which describes the specific error occurred
  // });
  }

            ///To signup using FirebaseAuth  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


        /// TO save signup data to firestore SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
  void saveUserData ()async{
    /// FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    /// User? user=FirebaseAuth.instance.currentUser;
     UserDataModel userDataModel=UserDataModel(
      /// uid: user!.uid,
       name: signinNameController.text,
       email: signinEmailController.text,
       phone: signinPhoneNumberController.text,
     );

    /// await firebaseFirestore.collection("user info").doc(user.uid).set(userDataModel.toMap());
     Fluttertoast.showToast(msg: "Data saved successfully");
  }
         /// TO save signup data to firestore EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE