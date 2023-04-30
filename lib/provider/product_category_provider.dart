





import 'package:flutter/material.dart';

import '../model_class/product_category_model_class.dart';

class ProductCategoryProvider with ChangeNotifier{
    /// final ProductCategoryRepository _productCategory=ProductCategoryRepository();
           List<ProductCategoryModelClass> _categoryData=[];
     List<ProductCategoryModelClass> get categoryData{
       return [..._categoryData];
     }
     void initializeCategoryProvider(){
       _categoryData=ProductCategoryRepository().categories;
       notifyListeners();
     }

   }