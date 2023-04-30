

class UserDataModel {
  String? uid;
  String ? name;
  String ? phone;
  String ? email;


  UserDataModel({this.uid, this.name, this.phone, this.email});

  ///set method
  Map<String , dynamic > toMap(){
    return{
      "uid":uid,
      "name":name,
      "phone":phone,
       "email":email,
    };
  }

  ///get method
  factory UserDataModel.fromMap(map){
    return UserDataModel(
         uid:map["uid"],
         name:map["name"],
         phone:map["phone"],
         email: map["email"],
    );
  }


}