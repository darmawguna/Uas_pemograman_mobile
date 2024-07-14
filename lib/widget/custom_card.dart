import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String image; // Assuming image is a String path

  const CustomCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Set a fixed width (adjust as needed)
      height: 100, // Set a fixed height (adjust as needed) to make it square
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Make all corners rounded
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4), // Adjust padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with expanded height
              Expanded(
                child: Image(
                  image: AssetImage(image),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover, // Ensure image covers the available space
                ),
              ),
              const SizedBox(
                  height: 4), // Add a small space between image and title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
