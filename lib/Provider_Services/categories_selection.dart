import 'package:flutter/material.dart';

class CategorySelection with ChangeNotifier{

  String _selectedCategory = '';
  IconData _selectedCategoryIcon = Icons.star;

  get selectedCategory => _selectedCategory;

  setCategory(String val){
    _selectedCategory = val;
    notifyListeners();
  }

  get selectedCategoryIcon => _selectedCategoryIcon;

  setCategoryIcon(IconData val){
    _selectedCategoryIcon = val;
    notifyListeners();
  }

}