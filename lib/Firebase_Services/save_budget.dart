import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SaveBudget{

  storeBudget(int amount ,String category){
    FirebaseFirestore.instance.collection('budget_categories').add(
        {
          'amount' : amount,
          'category': category,
          'spent' :  0
        });
  }
}