


import '../model_class/my_home_page_model_class.dart';

List<String>productPic=[
  'assets/car_pics/car1.jpg',
  'assets/car_pics/car2.jpg',
  'assets/car_pics/car3.jpg',
  'assets/car_pics/car4.jpg',
  'assets/car_pics/car5.jpg',
  'assets/car_pics/car6.jpg',
  'assets/car_pics/car7.jpg',
  'assets/car_pics/car8.jpg',
  'assets/car_pics/car9.jpg',
  'assets/car_pics/car10.jpg',
];

List<String>productDescription=[
  'Lamborghini',
  'Mustang',
  'Jaguar',
  'Ferrari',
  'Tesla',
  'Porsche',
  'BMW',
  'Rolls Royce',
  'Mercedes',
  'Jeep',
];

class MyHomePageRepository{
          MyHomePageModelClass myHomePageModelClass=MyHomePageModelClass(


            imageSliderPics: [
              for(int i=0;i<productPic.length;i++)
                productPic[i]
            ],
            productCategoryPicAndDescription:
            [
              for(int i=0;i<productPic.length;i++)
              ProductCategory(
                categoryPic:
                  productPic[i]
                ,
                categoryDescription:
                productDescription[i]
              ),

            ]
          );
}