

import 'package:hobi/model/news_model.dart';

List<CategoryModule> getCategories(){
  List<CategoryModule> categories = [];

  CategoryModule category = CategoryModule();
  category.categoryName ='Science';
  categories.add(category);

  category = CategoryModule();
  category.categoryName = 'Sports';
  categories.add(category);

  category = CategoryModule();
  category.categoryName = 'Business';
  categories.add(category);

  category = CategoryModule();
  category.categoryName = 'General';
  categories.add(category);

  category = CategoryModule();
  category.categoryName = 'Health';
  categories.add(category);

  category = CategoryModule();
  category.categoryName = 'Entertainment';
  categories.add(category);

  return categories;
}