// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Authentication_Services/firebase_authentication.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for TextFields
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // global form key for Sign In Form
    GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

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
                    Text('Sign Up'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create an account to continue'),
                  ],
                ),
                Form(
                  key: formKeySignUp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Enter Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Name !';
                          } else if (value.contains(RegExp(r'[0-9]'))) {
                            return 'please enter a valid Name';
                          }
                          return null;
                        },
                      ),
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
                          if (formKeySignUp.currentState!.validate()) {
                            // Saving Current State of Form
                            formKeySignUp.currentState?.save();
                            print('Sign Up Form is Valid.');

                            // Getting Text from textformfield
                            var name = nameController.text;
                            var emailAddress = emailController.text;
                            var password = passwordController.text;

                            // Signing Up the User Account through Firebase Authentication Feature
                            AuthenticationServices.signUp(
                                emailAddress, password, name);

                            Get.back();
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    InkWell(
                      child: const Text('Sign In'),
                      onTap: () {
                        Get.back();
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
