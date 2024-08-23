import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobi/module/nameModule.dart';
import 'package:hobi/pages/login_page.dart';
import 'package:provider/provider.dart';
import '../classes/auth_service.dart';
import '../components/my_textfield.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final TextEditingController email2Controller = TextEditingController();
final TextEditingController passWord2Controller = TextEditingController();
final TextEditingController confirmPassWordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  void signUserUp() async {
    // Show a loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passWord2Controller.text != confirmPassWordController.text) {
        // Close the loading dialog
        Navigator.pop(context);
        showErrorMessage('Passwords do not match');
        return;
      }

      if (email2Controller.text.isEmpty || passWord2Controller.text.isEmpty) {
        // Close the loading dialog
        Navigator.pop(context);
        showErrorMessage('Email and password cannot be empty');
        return;
      }

      // Create a new user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email2Controller.text,
        password: confirmPassWordController.text,
      );

      // Close the loading dialog
      Navigator.pop(context);

      // Show success message or navigate to login/home page
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Account created successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show error message
      showErrorMessage(e.message ?? 'An unknown error occurred');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  bool _isLoading = false;

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    User? user = await AuthService().signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Show error message if sign-in failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign in with Google')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferredUserName>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/images/logo.png',
                        color: Colors.black,
                      ),
                      const Text(
                        'Let\'s create a new account for you!',
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: value.userNameController,
                        hintText: 'Preferred Username',
                        obscureText: false,
                          inputFormatters: [LengthLimitingTextInputFormatter(9)]
                      ),
                      const SizedBox(height: 10.0),
                      MyTextField(
                        controller: email2Controller,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10.0),
                      MyTextField(
                        controller: passWord2Controller,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: confirmPassWordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          height: 65,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextButton(
                            onPressed: signUserUp,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                            ),
                          ),
                          Text('Or with'),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _signInWithGoogle,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Image.asset(
                                'lib/images/google.webp',
                                height: 45,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Image.asset(
                                'lib/images/apple.png',
                                height: 45,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already a user? ',
                            style: TextStyle(fontSize: 17, letterSpacing: 2.5),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 17,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
