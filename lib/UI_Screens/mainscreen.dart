import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goprogs_internship_task/Provider_Services/icon_provider.dart';
import 'package:goprogs_internship_task/UI_Screens/addEditCategoriesScreen.dart';
import 'package:goprogs_internship_task/UI_Screens/budget_detail_screen.dart';
import 'package:goprogs_internship_task/Components/no_active_budget.dart';
import 'package:goprogs_internship_task/Components/shimmer_effects.dart';
import 'package:goprogs_internship_task/Utils/constants.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditCategoryScreen(),
            ),
          );
        },
        backgroundColor: greenColor,
        shape: const CircleBorder(), // Ensures the button remains circular
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Centers the button at the bottom
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: greenColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Budget List",
          style: GoogleFonts.openSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xfff0f0f0),
          ),
        ),
      ),
      body: const _BudgetList(),
    );
  }
}

class _BudgetList extends StatefulWidget {
  const _BudgetList({super.key});

  @override
  State<_BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<_BudgetList> {
  final CollectionReference budgetCategories = FirebaseFirestore.instance.collection('budget_categories');

  @override
  Widget build(BuildContext context) {
    final iconProvider = Provider.of<CategoryIconProvider>(context);
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        _buildHeader(height),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: budgetCategories.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingState();
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const NoActiveBudget();
              }

              final data = snapshot.requireData;

              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  var document = data.docs[index];
                  var budget = document.data() as Map<String, dynamic>;

                  return _buildBudgetItem(context, budget, document.id, iconProvider);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(double height) {
    return Stack(
      children: [
        Container(height: height * 0.12),
        Container(height: height * 0.05, color: greenColor),
        Positioned(
          top: 15,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Your Budget",
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetItem(BuildContext context, Map<String, dynamic> budget, String docID, CategoryIconProvider iconProvider) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BudgetDetailScreen(
              amount: budget['amount'],
              spent: budget['spent'],
              category: budget['category'],
              docID: docID,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xfff0f0f0),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(
              iconProvider.categoryIcons[budget['category']] ?? Icons.category,
              size: 35,
            ),
            title: Text(budget['category']),
            subtitle: Row(
              children: [
                const Text(
                  "Left: ",
                  style: TextStyle(color: Colors.black),
                ),
                Text('${(budget['amount'] - budget['spent']).toString()}'),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "PKR ${budget['spent']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: greenColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text("/${budget['amount']}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
