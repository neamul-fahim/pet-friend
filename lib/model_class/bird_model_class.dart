

class BirdModelClass{
  String key='bird';
  String  id;
  String  name;
  List<String>  colors;
  String talk;
  String fly;
  String  age;
  double  price;
  String  imgUrl;

  BirdModelClass(this.id, this.name, this.colors,this.talk,this.fly ,this.age,this.price,this.imgUrl);
}


class BirdRepository {
  final List<BirdModelClass> birds = [
    BirdModelClass('bd1', 'budgerigar', ['blue', 'white', 'black'], "can't talk",'can fly','9 months', 75,'assets/bird_pics/budgerigar.jpg'),
    BirdModelClass('bd2', 'parrot', ['yellow', 'green', 'blue', 'white', 'red'],"can talk",'can fly','6 months', 75, 'assets/bird_pics/parrot.jpg'),
    BirdModelClass('bd3', 'owl', ['brown', 'white'],"can't talk", "can't fly",'1 year 2 months', 75,'assets/bird_pics/owl.jpg'),
    BirdModelClass('bd4', 'blue jay', ['blue', 'white', 'black'],"can't talk","can't fly", '1 year', 75,'assets/bird_pics/blue jay.jpg'),
    BirdModelClass('bd5', 'falcon', ['brown', 'black'],"can't talk", 'can fly','2 years', 75,'assets/bird_pics/falcon.jpg'),
  ];
}