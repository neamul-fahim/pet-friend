

  class ProductCategoryModelClass{
      String name;
      String imgUrl;

      ProductCategoryModelClass(this.name, this.imgUrl);
}

  class  ProductCategoryRepository{

       List<ProductCategoryModelClass> categories=[
         ProductCategoryModelClass('Pets', 'assets/dummy_pic/pets2.webp'),
         ProductCategoryModelClass('Food', 'assets/dummy_pic/pets_food1.jpg'),
            ProductCategoryModelClass('Accessory', 'assets/dummy_pic/pets_accessories.jpg'),


       ];
  }