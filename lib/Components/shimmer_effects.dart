import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WaitingState extends StatelessWidget {
  const WaitingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, position) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
              ),
              title: Container(
                width: 10,
                height: 10,
                color: Colors.white,
              ),
              subtitle: Container(
                width: 30,
                height: 10,
                color: Colors.white,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 10,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  Container(
                    width: 50,
                    height: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
