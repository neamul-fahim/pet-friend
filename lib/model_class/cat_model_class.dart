
class CatModelClass{
  String key='cat';
  String  id;
  String  breed;
  List<String>  colors;
  String trained;
  String  age;
  double  price;
  String  imgUrl;
  CatModelClass(this.id, this.breed, this.colors, this.trained,this.age,this.price,this.imgUrl);
}

  class CatRepository{
 final List<CatModelClass> cats= [
   CatModelClass('ct5', 'ragdoll',['white','black'] , 'trained','2 years 5 months',100,'assets/cat_pics/ragdoll.jpg'),
   CatModelClass('ct2', 'british shorthair',['ash'] , 'not trained','2 years',100,'assets/cat_pics/british shorthair.jpeg'),
   CatModelClass('ct3', 'maine coon',['brown','black'] ,'trained', '1 year',100,'assets/cat_pics/maine coon.jpeg'),
   CatModelClass('ct4', 'persian',['brown','white'] ,'not trained', '7 months',100,'assets/cat_pics/persian.jpeg'),
   CatModelClass('ct1', 'siamese',['white','black'] , 'trained','1 year',100,'assets/cat_pics/siamese.jpeg'),

 ];}