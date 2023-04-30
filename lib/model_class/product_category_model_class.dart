

  class ProductCategoryModelClass{
      String name;
      String imgUrl;

      ProductCategoryModelClass(this.name, this.imgUrl);
}

  class  ProductCategoryRepository{

       List<ProductCategoryModelClass> categories=[
         ProductCategoryModelClass('Pets', 'assets/bird_pics/blue jay.jpg'),
         ProductCategoryModelClass('Food', 'assets/bird_pics/blue jay.jpg'),
            ProductCategoryModelClass('Accessories', 'assets/bird_pics/blue jay.jpg'),

       ];
  }