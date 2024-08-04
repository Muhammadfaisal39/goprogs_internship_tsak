import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goprogs_internship_task/Utils/constants.dart';


class NoActiveBudget extends StatelessWidget {
  const NoActiveBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 150),
      child: Container(
        height: 310,
        color: const Color(0xfff0f0f0),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20, left: 20, right: 20),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                ),
                title: Container(
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                subtitle: Container(
                  width: 40,
                  height: 08,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                trailing: Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.card_giftcard_rounded,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                ),
                title: Container(
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                subtitle: Container(
                  width: 40,
                  height: 08,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                trailing: Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.connecting_airports_rounded,
                    size: 45,
                    color: Colors.grey[400],
                  ),
                ),
                title: Container(
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                subtitle: Container(
                  width: 40,
                  height: 08,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                trailing: Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "No Active Budget",
                style: GoogleFonts.openSans(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: greenColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
