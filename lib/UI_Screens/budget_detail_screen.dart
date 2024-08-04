import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goprogs_internship_task/Components/Button.dart';
import 'package:goprogs_internship_task/Firebase_Services/update_budget.dart';
import 'package:goprogs_internship_task/Utils/constants.dart';
import 'package:goprogs_internship_task/Utils/utils.dart';

class BudgetDetailScreen extends StatefulWidget {
  final String category;
  final int amount;
  final int spent;
  final String docID;

  const BudgetDetailScreen({
    super.key,
    required this.amount,
    required this.category,
    required this.spent,
    required this.docID,
  });

  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {
  bool _showUpdateFields = false;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _spentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.amount.toString();
    _spentController.text = widget.spent.toString();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _spentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Budget Details",
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xfff0f0f0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(height),
            if (_showUpdateFields) _buildUpdateFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double height) {
    return Stack(
      children: [
        Container(height: height * 0.28),
        Container(height: height * 0.04, color: greenColor),
        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: Container(
            height: height * 0.19,
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
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryTitle(),
                  const SizedBox(height: 5),
                  _buildBudgetInfo(),
                  const SizedBox(height: 15),
                  _buildRemainingAmount(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.category,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        PopupMenuButton<String>(
          onSelected: (String result) async {
            if (result == 'Delete') {
              try {
                await FirebaseFirestore.instance
                    .collection('budget_categories')
                    .doc(widget.docID)
                    .delete();
                Navigator.pop(context);
              } catch (e) {
                Utils.flushBarWarningMessage(e.toString(), context);
              }
            } else if (result == 'Update') {
              setState(() {
                _showUpdateFields = true;
              });
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'Delete',
              child: Text('Delete'),
            ),
            const PopupMenuItem<String>(
              value: 'Update',
              child: Text('Update'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBudgetInfo() {
    return Row(
      children: [
        Text(
          "PKR ${widget.spent.toString()}/",
          style: TextStyle(
            fontSize: 23,
            color: greenColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          widget.amount.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildRemainingAmount() {
    return Row(
      children: [
        Text(
          "Remaining Amount: ",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(width: 4),
        Text((widget.amount - widget.spent).toString()),
      ],
    );
  }

  Widget _buildUpdateFields() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _spentController,
            decoration: const InputDecoration(
              labelText: 'Amount Spent',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 30),
          Button(
            onPressed: () {
              int amount = int.parse(_amountController.text);
              int spentAmount = int.parse(_spentController.text);
              UpdateBudget().updateBudgetCategory(
                context,
                widget.docID,
                amount,
                spentAmount,
              );
              Navigator.pop(context);
            },
            title: "Update",
            color: greenColor,
          ),
        ],
      ),
    );
  }
}
