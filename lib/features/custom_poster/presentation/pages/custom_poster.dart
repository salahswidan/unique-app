import 'package:flutter/material.dart';

class CustomPoster extends StatelessWidget {
  const CustomPoster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              'Create Your Custom Poster',
              style: TextStyle(
                fontSize: 36.0,
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              textAlign: TextAlign.center,
              'Upload your favorite image, choose the perfect size and frame to create a unique piece of art.',
              style: TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
