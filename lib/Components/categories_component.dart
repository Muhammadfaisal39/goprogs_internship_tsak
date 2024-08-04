import 'package:flutter/material.dart';
import 'package:goprogs_internship_task/Provider_Services/categories_selection.dart';
import 'package:goprogs_internship_task/Utils/constants.dart';
import 'package:provider/provider.dart';

class CatergoryCard extends StatelessWidget {


  IconData cardIcon;
  String title;
  final VoidCallback? onPressed;

  CatergoryCard({super.key, required this.cardIcon, required this.title,this.onPressed,});

  @override
  Widget build(BuildContext context) {
    final categorySelection = Provider.of<CategorySelection>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(50),
                border: categorySelection
                    .selectedCategory ==
                    title
                    ? Border.all(
                    color: greenColor,
                    width: 3)
                    : Border.all(
                    color: const Color(0xfff0f0f0))) ,
            child: Center(child: Icon(cardIcon)),
          ),
        ),
        const SizedBox(height: 8,),
        Text(title,style: const TextStyle(
            fontSize: 13
        ),),
      ],
    );
  }
}
