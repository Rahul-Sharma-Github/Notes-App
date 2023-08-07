// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/Pages/signup/signup_page.dart';

import '../../Authentication_Services/firebase_authentication.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for TextFields
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // global form key for Sign In Form
    GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign In'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign In to continue'),
                  ],
                ),
                Form(
                  key: formKeySignIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Enter Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email !';
                          } else if (!value.contains('@')) {
                            return 'please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Enter Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be 6 character long !';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKeySignIn.currentState!.validate()) {
                            // Saving Current State of Form
                            formKeySignIn.currentState?.save();
                            print('Form is Valid.');

                            // Getting Text from textformfield
                            var emailAddress = emailController.text;
                            var password = passwordController.text;

                            // Signing In the User Account through Firebase Authentication Feature
                            AuthenticationServices.signIn(
                                emailAddress, password);
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    InkWell(
                      child: const Text('Sign Up'),
                      onTap: () {
                        Get.to(() => const SignUpPage());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
