
// ignore_for_file: dead_code, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'zakat_welcome_screen.dart'; // Import your welcome page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;

    // Check if the screen is considered "small"
    bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: isSmallScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.home, color: Colors.white), // Home icon
                  const SizedBox(width: 5),
                  const Text(
                    'HOME PAGE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.home, color: Colors.white), // Home icon
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
                  const Spacer(), // Pushes the list to the right
                  _buildHeaderList(screenSize), // The list with headings like Home, About, etc.
                ],
              ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          _buildSettingsMenu(context, isSmallScreen), // Updated settings menu
          _buildProfileIcon(context), // Profile icon on the right corner
        ],
        leading: _buildMenuButton(context), // Menu button on the left side
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  // Widget to build the list in the header (only for larger screens)
  Widget _buildHeaderList(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the list items
      children: [
        _HeaderItem(title: 'Home', icon: Icons.home),
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'About', icon: Icons.info),
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'Explore', icon: Icons.explore),
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'Wallet', icon: Icons.account_balance_wallet),
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'Notes', icon: Icons.note),
      ],
    );
  }

  // Custom Widget for each header item
  Widget _HeaderItem({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  // Updated Settings Menu to include removed header items for smaller screens
  Widget _buildSettingsMenu(BuildContext context, bool isSmallScreen) {
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
          if (isSmallScreen) ...[
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'Home',
              child: ListTile(
                leading: Icon(Icons.home, color: Colors.black),
                title: Text('Home'),
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
              value: 'Explore',
              child: ListTile(
                leading: Icon(Icons.explore, color: Colors.black),
                title: Text('Explore'),
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
          ],
        ];
      },
      icon: const Icon(Icons.settings, color: Colors.white),
      offset: const Offset(0, 58),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white.withOpacity(0.9),
    );
  }

  // Method to build the menu button (top-left)
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

  // Method to build the profile icon with dropdown (top-right)
  Widget _buildProfileIcon(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Sign Out') {
          _showLogoutConfirmation(context);
        } else if (value == 'Edit Profile') {
          // Handle Edit Profile
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
      icon: _buildProfileImage(),
      offset: const Offset(0, 58),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white.withOpacity(0.9),
    );
  }

  // Method to build profile image
  Widget _buildProfileImage() {
    bool hasProfilePicture = false;

    if (hasProfilePicture) {
      return const CircleAvatar(
        backgroundImage: NetworkImage('https://example.com/profile_picture.jpg'),
        radius: 18,
      );
    } else {
      return const Icon(Icons.account_circle, size: 36, color: Colors.white);
    }
  }

  // Method to show logout confirmation dialog
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

