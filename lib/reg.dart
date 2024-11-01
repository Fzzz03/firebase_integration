import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'input_field.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isPasswordValid(String password) {
    final hasMinLength = password.length >= 8;
    final hasNumber = password.contains(RegExp(r'\d'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    return hasMinLength && hasNumber && hasSpecialChar && hasUpperCase;
  }

  Future<void> register() async {
    if (!isPasswordValid(passwordController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Password Requirements"),
          content: const Text(
            "Your password must:\n"
            "- Contain at least 8 characters\n"
            "- Include at least one number\n"
            "- Include at least one special character\n"
            "- Include at least one uppercase letter",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(nameController.text.trim());

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Verification Email Sent"),
            content: const Text(
                "A verification email has been sent to your email. Please verify to continue."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );

        await user.sendEmailVerification();
        checkVerificationStatus(user);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> checkVerificationStatus(User user) async {
    await user.reload();
    user = FirebaseAuth.instance.currentUser!;
    if (user.emailVerified) {
      navigateToHomePage();
    } else {
      Timer(const Duration(seconds: 3), () => checkVerificationStatus(user));
    }
  }

  void navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(showVerificationMessage: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Create your account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30),
                            InputField(
                              hintText: 'Name',
                              icon: Icons.person,
                              controller: nameController,
                              onChanged: (password) {},
                            ),
                            const SizedBox(height: 20),
                            InputField(
                              hintText: 'Email',
                              icon: Icons.email,
                              controller: emailController,
                              onChanged: (password) {},
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                InputField(
                                  hintText: 'Password',
                                  icon: Icons.lock,
                                  obscureText: !_isPasswordVisible,
                                  controller: passwordController,
                                  onChanged: (password) {},
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                InputField(
                                  hintText: 'Confirm Password',
                                  icon: Icons.lock_outline,
                                  obscureText: !_isConfirmPasswordVisible,
                                  controller: confirmPasswordController,
                                  onChanged: (password) {},
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isConfirmPasswordVisible =
                                            !_isConfirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: register,
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
