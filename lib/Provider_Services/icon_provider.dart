import 'package:flutter/material.dart';

class CategoryIconProvider with ChangeNotifier {
  String _selectedCategory = '';
  IconData _selectedCategoryIcon = Icons.category; // Default icon

  final Map<String, IconData> categoryIcons = {
    'Travel': Icons.train,
    'Food & Drinks': Icons.fastfood,
    'Grocery': Icons.shopping_cart,
    'Medical': Icons.monitor_heart_outlined,
    'Education': Icons.history_edu,
    'Home': Icons.home,
    'Gifts': Icons.card_giftcard_outlined,
    'Health & Fitness': Icons.health_and_safety,
    'Mobile': Icons.mobile_friendly_rounded,
    'Personal': Icons.person,
    'Transport': Icons.time_to_leave_rounded,
    'Entertainment': Icons.airplane_ticket,
    'Bills & Utilities': Icons.receipt_long_rounded,
    'Shopping': Icons.shopping_bag_rounded,
    'Family': Icons.family_restroom_rounded,
    'Electronics': Icons.electric_meter,
    'Committee': Icons.person_add_alt_1_rounded,
    'Other Expanses': Icons.clean_hands_sharp,
  };

  IconData get selectedCategoryIcon => _selectedCategoryIcon;

  set selectedCategory(String category) {
    _selectedCategory = category;
    _selectedCategoryIcon = categoryIcons[category] ?? Icons.category;
    notifyListeners();
  }
}
