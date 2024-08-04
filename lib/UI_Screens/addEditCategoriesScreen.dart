import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goprogs_internship_task/Components/Button.dart';
import 'package:goprogs_internship_task/Components/categories_component.dart';
import 'package:goprogs_internship_task/Firebase_Services/save_budget.dart';
import 'package:goprogs_internship_task/Provider_Services/categories_selection.dart';
import 'package:goprogs_internship_task/UI_Screens/mainscreen.dart';
import 'package:goprogs_internship_task/Utils/utils.dart';
import 'package:goprogs_internship_task/Utils/constants.dart';
import 'package:provider/provider.dart';

class AddEditCategoryScreen extends StatefulWidget {

  const AddEditCategoryScreen({super.key,});

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _amountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final categorySelection = Provider.of<CategorySelection>(context);
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAmountInput(height),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _buildCategorySelection(height, categorySelection),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: greenColor,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Create Budget",
        style: GoogleFonts.openSans(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: const Color(0xfff0f0f0),
        ),
      ),
    );
  }

  Widget _buildAmountInput(double height) {
    return Stack(
      children: [
        Container(height: height * 0.15),
        Container(height: height * 0.08, color: greenColor),
        Positioned(
          top: 35,
          left: 20,
          right: 20,
          child: Container(
            height: height * 0.07,
            decoration: BoxDecoration(
              color: const Color(0xfff0f0f0),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("PKR", style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 70,
                    child: Center(
                      child: TextFormField(
                        cursorColor: greenColor,
                        cursorHeight: 20,
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelection(double height, CategorySelection categorySelection) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Category",
            style: GoogleFonts.openSans(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: height * 0.03),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryRow(categorySelection, 0),
                      const SizedBox(height: 20),
                      _buildCategoryRow(categorySelection, 1),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Button(
            title: "SAVE",
            color: greenColor,
            onPressed: () => _onCreateBudgetPressed(categorySelection, context),
          ),
          SizedBox(height: height * 0.02,),
          Button(
            title: "CANCEL",
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(CategorySelection categorySelection, int row) {
    final List<List<Map<String, dynamic>>> categories = [
      [
        {'icon': Icons.train, 'title': 'Travel'},
        {'icon': Icons.fastfood, 'title': 'Food & Drinks'},
        {'icon': Icons.local_grocery_store, 'title': 'Grocery'},
        {'icon': Icons.monitor_heart_outlined, 'title': 'Medical'},
        {'icon': Icons.history_edu, 'title': 'Education'},
        {'icon': Icons.home_rounded, 'title': 'Home'},
        {'icon': Icons.card_giftcard_rounded, 'title': 'Gifts'},
        {'icon': Icons.health_and_safety, 'title': 'Health & Fitness'},
        {'icon': Icons.mobile_friendly_rounded, 'title': 'Mobile'},
      ],
      [
        {'icon': Icons.person, 'title': 'Personal'},
        {'icon': Icons.time_to_leave_rounded, 'title': 'Transport'},
        {'icon': Icons.airplane_ticket, 'title': 'Entertainment'},
        {'icon': Icons.receipt_long_rounded, 'title': 'Bills & Utilities'},
        {'icon': Icons.shopping_bag_rounded, 'title': 'Shopping'},
        {'icon': Icons.family_restroom_rounded, 'title': 'Family'},
        {'icon': Icons.electric_meter_outlined, 'title': 'Electronics'},
        {'icon': Icons.person_add_alt_1_rounded, 'title': 'Committee'},
        {'icon': Icons.clean_hands_sharp, 'title': 'Other Expenses'},
      ]
    ];

    return Row(
      children: categories[row].map((category) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CatergoryCard(
            cardIcon: category['icon'],
            title: category['title'],
            onPressed: () {
              categorySelection.setCategory(category['title']);
              categorySelection.setCategoryIcon(category['icon']);
            },
          ),
        );
      }).toList(),
    );
  }

  void _onCreateBudgetPressed(CategorySelection categorySelection, BuildContext context) {
    if (_amountController.text.isEmpty) {
      Utils.flushBarWarningMessage("Please Enter Amount", context);
    } else if (categorySelection.selectedCategory.isEmpty) {
      Utils.flushBarWarningMessage("Please Select Category", context);
    } else {
      int amount = int.parse(_amountController.text);
      String selectedCategory = categorySelection.selectedCategory;
      try {
        SaveBudget().storeBudget(amount, selectedCategory);
        Utils.flushBarSuccessMessage("Budget Created Successfully", context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainScreen()));
      } catch (e) {
        Utils.flushBarWarningMessage(e.toString(), context);
      }
    }
  }
}
