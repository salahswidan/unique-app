import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/features/auth/presentation/widgets/auth_text_form_field.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthLogo(icon: Icons.person_outline),
              SizedBox(height: 16.0),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 30.0,
                  color: Color.fromRGBO(75, 85, 99, 1),
                ),
              ),
              Text(
                'Sign in to your Unique account',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(75, 85, 99, 0.9),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10), // x = 0, y = 10
                      blurRadius: 15,
                      spreadRadius: -3, // negative spread
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 4), // x = 0, y = 4
                      blurRadius: 6,
                      spreadRadius: -4, // negative spread
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AuthTextFormField(
                      label: 'Email Address',
                      hint: 'Enter your email address',
                    ),
                    SizedBox(height: 16.0),
                    AuthTextFormField(
                      label: 'Password',
                      hint: 'Enter your password',
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(209, 213, 219, 1),
                              ),
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color(0xffff1d48),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    AuthButton(
                      buttonText: 'Sign In',
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(75, 85, 99, 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoute.signUpPage),
                          child: Text(
                            'Create account',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffff1d48),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
