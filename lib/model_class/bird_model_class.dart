

class BirdModelClass {
   String? key ;
  final String? id;
  final String? name;
  final List<String>? colors;
  final String? talk;
  final String? fly;
  final String? age;
  final double? price;
   final String? imgUrl;
   List<String>? imgURL;

  BirdModelClass({this.key="bird",this.id, this.name, this.colors, this.talk, this.fly, this.age, this.price, this.imgUrl,this.imgURL});

  Map<String, dynamic> toFirebase() {
    return {
      if(key!=null) "key":key,
      if(id != null) "id": id,
      if(name != null) "name": name,
      if(colors != null) "colors": colors,
      if(talk != null) "talk": talk,
      if(fly != null) "fly": fly,
      if(age != null) "age": age,
      if(price != null) "price": price,
      if(imgURL != null) "imgURL": imgURL,
    };
  }
}

class BirdRepository {
  final List<BirdModelClass> birds = [
    BirdModelClass( name: 'budgerigar',colors:  ['blue', 'white', 'black'], talk: "can't talk",fly: 'can fly',age: '9 months', price: 75,imgUrl: 'assets/bird_pics/budgerigar.jpg'),
    BirdModelClass( name: 'parrot', colors: ['yellow', 'green', 'blue', 'white', 'red'],talk: "can talk",fly: 'can fly',age: '6 months',price:  75,imgUrl:  'assets/bird_pics/parrot.jpg'),
    BirdModelClass( name: 'owl', colors: ['brown', 'white'],talk: "can't talk", fly: "can't fly",age: '1 year 2 months',price:  75,imgUrl: 'assets/bird_pics/owl.jpg'),
    BirdModelClass( name: 'blue jay',colors:  ['blue', 'white', 'black'],talk:  "can't talk",fly:  "can't fly", age: '1 year', price: 75,imgUrl: 'assets/bird_pics/blue jay.jpg'),
    BirdModelClass( name: 'falcon',colors:  ['brown', 'black'],talk: "can't talk",fly:  'can fly',age: '2 years', price: 75,imgUrl: 'assets/bird_pics/falcon.jpg'),
  ];
}