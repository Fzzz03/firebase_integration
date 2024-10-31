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
  bool _isRegisterButtonEnabled = false;

  // Password conditions
  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasUpperCase = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    passwordController.removeListener(_validatePassword);
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      String password = passwordController.text;
      hasMinLength = password.length >= 8;
      hasNumber = password.contains(RegExp(r'\d'));
      hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      _isRegisterButtonEnabled =
          hasMinLength && hasNumber && hasSpecialChar && hasUpperCase;
    });
  }

  Future<void> register() async {
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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(nameController.text.trim());
        await user.sendEmailVerification();

        // Show dialog box for verification email sent
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
        ).then((_) {
          checkVerificationStatus(user);
        });
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

  Widget buildPasswordCriteria(String text, bool conditionMet) {
    return Row(
      children: [
        Icon(
          conditionMet ? Icons.check_circle : Icons.cancel,
          color: conditionMet ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(
              color: conditionMet ? Colors.green : Colors.red,
            )),
      ],
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
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30),
                            InputField(
                              hintText: 'Name',
                              icon: Icons.person,
                              controller: nameController, onChanged: (password) {  },
                            ),
                            const SizedBox(height: 20),
                            InputField(
                              hintText: 'Email',
                              icon: Icons.email,
                              controller: emailController, onChanged: (password) {  },
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                InputField(
                                  hintText: 'Password',
                                  icon: Icons.lock,
                                  obscureText: !_isPasswordVisible,
                                  controller: passwordController, onChanged: (password) {  },
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
                            // Password criteria
                            buildPasswordCriteria(
                                "Must contain at least 8 characters",
                                hasMinLength),
                            buildPasswordCriteria("Must contain at least one number",
                                hasNumber),
                            buildPasswordCriteria(
                                "Must contain at least one special character",
                                hasSpecialChar),
                            buildPasswordCriteria(
                                "Must contain at least one capital letter",
                                hasUpperCase),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                InputField(
                                  hintText: 'Confirm Password',
                                  icon: Icons.lock_outline,
                                  obscureText: !_isConfirmPasswordVisible,
                                  controller: confirmPasswordController, onChanged: (password) {  },
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
                                backgroundColor: _isRegisterButtonEnabled
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _isRegisterButtonEnabled ? register : null,
                              child: const Text(
                                'Register Now',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.white),
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
