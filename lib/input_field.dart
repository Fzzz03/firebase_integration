import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller; // Add this line

  const InputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.controller, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Use the controller here
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
