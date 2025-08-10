import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/features/auth/presentation/widgets/auth_text_form_field.dart';
import '../../../../core/constants/app_route.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
              AuthLogo(icon: Icons.person_add_alt),
              SizedBox(height: 16.0),
              Text(
                'Create your account',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 30.0,
                  color: Color.fromRGBO(75, 85, 99, 1),
                ),
              ),
              Text(
                'Join Unique and start creating beautiful posters',
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
                      label: 'Full Name',
                      hint: 'Enter your full name',
                    ),
                    SizedBox(height: 16.0),
                    AuthTextFormField(
                      label: 'Email Address',
                      hint: 'Enter your email address',
                    ),
                    SizedBox(height: 16.0),
                    AuthTextFormField(
                      label: 'Password',
                      hint: 'Create a password (min. 6 characters)',
                    ),
                    SizedBox(height: 16.0),
                    AuthTextFormField(
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                    ),
                    SizedBox(height: 16.0),
                    AuthButton(
                      buttonText: 'Create Account',
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(75, 85, 99, 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoute.loginPage),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffff1d48),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: TextStyle(
                          color: Color.fromRGBO(107, 114, 128, 1),
                          fontSize: 12.0,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of Service ',
                            style: TextStyle(
                              color: Color(0xffff1d48),
                              fontSize: 12.0,
                            ),
                          ),
                          TextSpan(
                            text: 'and ',
                            style: TextStyle(
                              color: Color.fromRGBO(107, 114, 128, 1),
                              fontSize: 12.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xffff1d48),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
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
