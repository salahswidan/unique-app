import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0,
      height: 64.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFf43f5e), // first color
            Color(0xFFec4899), // second color
            // you can add more colors if needed
          ],
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 34.0,
      ),
    );
  }
}
