

import 'package:flutter/material.dart';

class Test extends StatelessWidget {
   const Test({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var Url=
"https://firebasestorage.googleapis.com/v0/b/pet-friend-2d286.appspot.com/o/pet_friend%2Fproducts%2Fbird%2FCtACFxZOTHhMPWrOSFRx%2Fpic1?alt=media&token=af55da6f-7ede-4176-952c-34a9d273786e";



    return Scaffold(
      body: Image.network(Url)
    );
  }
}
