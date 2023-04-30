

class DogModelClass{
  String key='dog';
  String  id;
  String  breed;
  List<String>  colors;
  String trained;
  String  age;
  double  price;
  String  imgUrl;

  DogModelClass(this.id, this.breed, this.colors,this.trained, this.age,this.price,this.imgUrl);
}

  class DogRepository{
final List<DogModelClass> dogs= [

  DogModelClass('dg4','golden retriever' , ['white','brown'], 'trained','1 year', 100,'assets/dog_pics/golden retriever.jpg'),
  DogModelClass('dg3','labrador' , ['white','brown'], 'not trained','5 years', 100,'assets/dog_pics/labrador.jpg'),
  DogModelClass('dg1','siberian huskey' , ['white','black'],'trained', '5 months', 100,'assets/dog_pics/siberian huskey.jpeg'),
  DogModelClass('dg1','german shepherd' , ['brown','black'],'not trained', '3 years', 100,'assets/dog_pics/german shepherd.jpg'),
  DogModelClass('dg2','bull dog' , ['white','black','brown'],'trained', '2 years', 100,'assets/dog_pics/bull dog.jpg'),
];}