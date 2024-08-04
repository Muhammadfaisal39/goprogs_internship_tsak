import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:goprogs_internship_task/Utils/utils.dart';

class UpdateBudget{
  Future<void> updateBudgetCategory(BuildContext context,String docID, int amount, int spent) async {
    try {
      await FirebaseFirestore.instance
          .collection('budget_categories')
          .doc(docID)
          .update({
        'amount': amount,
        'spent': spent,
      });
      Utils.flushBarSuccessMessage("Budget Updated Successfully!", context);
    } catch (e) {
      Utils.flushBarWarningMessage(e.toString(), context);
    }
  }
}