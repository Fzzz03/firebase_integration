// ignore_for_file: dead_code, unused_import

import 'package:flutter/material.dart';
import 'zakat_welcome_screen.dart'; // Import your welcome page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarHeight = kToolbarHeight; // Default AppBar height

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.home, color: Colors.white), // Home icon
                SizedBox(width: screenSize.width * 0.02), // Space between icon and text
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
          _buildProfileIcon(context), // Profile icon on the right corner
        ],
        leading: _buildMenuButton(context), // Menu button on the left side
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  // Widget to build the list in the header
  Widget _buildHeaderList(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the list items
      children: [
        _HeaderItem(title: 'Home', icon: Icons.home), // Home item with icon
        SizedBox(width: screenSize.width * 0.05), // Increased space between items
        _HeaderItem(title: 'About', icon: Icons.info), // About item with icon
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'Explore', icon: Icons.explore), // Explore item with icon
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'Wallet', icon: Icons.account_balance_wallet), // Wallet item with icon
        SizedBox(width: screenSize.width * 0.05),
        _HeaderItem(title: 'Notes', icon: Icons.note), // Notes item with icon
      ],
    );
  }

  // Custom Widget for each header item
  Widget _HeaderItem({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white), // Icon for the header item
        const SizedBox(width: 5), // Space between icon and text
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500, // Less bold than "HOME PAGE"
            color: Colors.white, // White text color
            fontSize: 18, // Slightly smaller font size
          ),
        ),
      ],
    );
  }

  // Method to build the menu button (top-left)
  Widget _buildMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Settings') {
          _showSettingsMenu(context); // Show nested settings menu
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
              leading: Icon(Icons.settings, color: Colors.black), // Gear icon for settings
              title: Text('Settings'),
            ),
          ),
          const PopupMenuItem(
            value: 'Help',
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.black), // Help icon
              title: Text('Help'),
            ),
          ),
          const PopupMenuItem(
            value: 'Contact Us',
            child: ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.black), // Contact icon
              title: Text('Contact Us'),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.menu, color: Colors.white), // Menu button icon
      offset: const Offset(0, 58), // Offset to start the dropdown below the header
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      color: Colors.white.withOpacity(0.9), // Glass-like look with reduced opacity
    );
  }

  // Method to show the settings menu with nested options
  void _showSettingsMenu(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero); // Get the current position of the settings button

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          offset.dx, offset.dy + 60, 0, 0), // Adjusted position
      items: [
        PopupMenuItem<String>(
          value: 'Theme',
          child: const ListTile(
            title: Text('Theme'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Privacy',
          child: const ListTile(
            title: Text('Privacy and Security'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'Theme') {
        // You can implement theme selection in the future
      } else if (value == 'Privacy') {
        // Handle Privacy and Security option
      }
    });
  }

  // Method to build the profile icon with dropdown (top-right)
  Widget _buildProfileIcon(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Sign Out') {
          _showLogoutConfirmation(context); // Show logout confirmation
        } else if (value == 'Edit Profile') {
          // Handle Edit Profile
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'Sign Out',
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.black), // Logout icon
              title: Text('Sign Out'),
            ),
          ),
          const PopupMenuItem(
            value: 'Edit Profile',
            child: ListTile(
              leading: Icon(Icons.edit, color: Colors.black), // Edit icon
              title: Text('Edit Profile'),
            ),
          ),
        ];
      },
      icon: _buildProfileImage(), // Either user's profile image or default icon
      offset: const Offset(0, 58), // Offset to align dropdown below AppBar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for dropdown
      ),
      color: Colors.white.withOpacity(0.9), // Glass-like look with reduced opacity
    );
  }

  // Method to build profile image (either user's picture or default icon)
  Widget _buildProfileImage() {
    bool hasProfilePicture = false; // Example logic

    if (hasProfilePicture) {
      return const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://example.com/profile_picture.jpg', // Replace with actual image URL
        ),
        radius: 18, // Profile image size
      );
    } else {
      return const Icon(Icons.account_circle, size: 36, color: Colors.white); // Default profile icon
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
                Navigator.pushReplacementNamed(context ,'/'); // Navigate to welcome page
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
