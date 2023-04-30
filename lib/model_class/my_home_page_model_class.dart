
class MyHomePageModelClass{
   List<String>?imageSliderPics;
    List<ProductCategory>?productCategoryPicAndDescription;

   MyHomePageModelClass(
   {this.imageSliderPics, this.productCategoryPicAndDescription});
}
class ProductCategory{
   String?categoryPic;
   String ?categoryDescription;

   ProductCategory({this.categoryPic, this.categoryDescription});
}