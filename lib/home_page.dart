// ignore_for_file: dead_code, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import your profile page
import 'zakat_welcome_screen.dart'; // Import your welcome page

class HomePage extends StatelessWidget {
  const HomePage({super.key, required bool showVerificationMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, color: Colors.white),
            const SizedBox(width: 5),
            const Text(
              'HOME PAGE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: _buildMenuButton(context),
        actions: [
          _buildProfileIcon(context),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: Text('Main Content'), // Placeholder for main content
          ),
          _buildVerificationMessage(context),
        ],
      ),
    );
  }

  Widget _buildVerificationMessage(BuildContext context) {
    // This is your message that will be shown at the bottom
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: const Text(
          'Please verify your email address to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Settings') {
          _showSettingsMenu(context);
        } else if (value == 'Help') {
          // Handle Help option
        } else if (value == 'Contact Us') {
          // Handle Contact Us option
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'Settings',
            child: ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('Settings'),
            ),
          ),
          const PopupMenuItem(
            value: 'Help',
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.black),
              title: Text('Help'),
            ),
          ),
          const PopupMenuItem(
            value: 'Contact Us',
            child: ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.black),
              title: Text('Contact Us'),
            ),
          ),
          const PopupMenuItem(
            value: 'About',
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.black),
              title: Text('About'),
            ),
          ),
          const PopupMenuItem(
            value: 'Wallet',
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.black),
              title: Text('Wallet'),
            ),
          ),
          const PopupMenuItem(
            value: 'Notes',
            child: ListTile(
              leading: Icon(Icons.note, color: Colors.black),
              title: Text('Notes'),
            ),
          ),
          const PopupMenuItem(
            value: 'Explore',
            child: ListTile(
              leading: Icon(Icons.explore, color: Colors.black),
              title: Text('Explore'),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.menu, color: Colors.white),
      offset: const Offset(0, 58),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white.withOpacity(0.9),
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Sign Out') {
          _showLogoutConfirmation(context);
        } else if (value == 'Edit Profile') {
          // Navigate to the Profile Page when "Edit Profile" is clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'Sign Out',
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Sign Out'),
            ),
          ),
          const PopupMenuItem(
            value: 'Edit Profile',
            child: ListTile(
              leading: Icon(Icons.edit, color: Colors.black),
              title: Text('Edit Profile'),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.account_circle, size: 36, color: Colors.white),
      offset: const Offset(0, 58),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white.withOpacity(0.9),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy + 60, 0, 0),
      items: [
        const PopupMenuItem<String>(
          value: 'Theme',
          child: ListTile(
            title: Text('Theme'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Privacy',
          child: ListTile(
            title: Text('Privacy and Security'),
          ),
        ),
      ],
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('ARE YOU SURE YOU WANT TO LOG-OUT?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
