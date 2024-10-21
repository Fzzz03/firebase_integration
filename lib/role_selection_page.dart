import 'package:flutter/material.dart';
import 'zakat_login_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select Your Role',
                  style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 237, 241, 241),
                  ),
                ),
                const SizedBox(height: 40),
                _RoleButton(
                  role: 'I\'m a Donor    ',
                  icon: Icons.volunteer_activism,
                  color: const Color(0xFF009688),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ZakatLoginPage(role: 'Donor')),
                    );
                  },
                ),
                const SizedBox(height: 40),
                _RoleButton(
                  role: 'I\'m a Receiver',
                  icon: Icons.handshake,
                  color: const Color(0xFF009688),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ZakatLoginPage(role: 'Receiver')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String role;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _RoleButton({
    required this.role,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        role,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
