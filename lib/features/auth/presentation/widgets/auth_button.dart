import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
  });

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 10), // x=0, y=10
            blurRadius: 15,
            spreadRadius: -3, // negative spread same as CSS '-3px'
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4), // x=0, y=4
            blurRadius: 6,
            spreadRadius: -4, // negative spread same as CSS '-4px'
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFF43F5E), // from (#f43f5e)
            Color(0xFFEC4899), // to (#ec4899)
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          elevation: 0.0,
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
