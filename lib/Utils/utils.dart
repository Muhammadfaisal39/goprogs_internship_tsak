import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
class Utils{
  static void flushBarWarningMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.warning_rounded,color: Colors.black,),
      message: message,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
    )..show(context));
  }

  static void flushBarSuccessMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.verified_outlined,color: Colors.black,),
      message: message,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
    )..show(context));
  }
}