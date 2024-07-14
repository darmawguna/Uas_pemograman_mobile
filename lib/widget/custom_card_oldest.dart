import 'package:flutter/material.dart';

class CustomCards extends StatelessWidget {
  final String title;
  final String image; // Assuming image is a String path

  const CustomCards({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, 
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), 
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4), // Adjust padding
          child: Image(
              image: AssetImage(image),
              width: double.infinity,
              height: double.infinity,
          ),
        ),
      ),
    );
  }
}
