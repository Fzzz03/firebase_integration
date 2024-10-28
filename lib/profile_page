import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // Developer configurable properties
  final Color backArrowColor; // Color of the back arrow
  final double backArrowSize; // Size of the back arrow

  // Constructor to initialize the properties
  const ProfilePage({
    super.key,
    this.backArrowColor = Colors.white, // Default color
    this.backArrowSize = 30.0, // Default size
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Use configurable color here
            size: 30, // Use configurable size here
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white), // White title text
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Maintain the theme
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 70, // Circle size
              backgroundImage: NetworkImage(
                'https://example.com/profile_picture.jpg', // Replace with actual user image URL
              ),
              child: const Icon(
                Icons.account_circle,
                size: 80, // Size of default icon if no image is available
                color: Colors.grey, // Grey color for default icon
              ),
            ),
            const SizedBox(height: 20), // Space between elements

            // User Name Heading
            const Text(
              'YOUR NAME',
              style: TextStyle(
                color: Colors.white, // White text color
                fontSize: 20, // Font size for name heading
                fontWeight: FontWeight.bold, // Bold heading
              ),
            ),
            const SizedBox(height: 10), // Space between heading and input

            // User Name Input Field
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of screen
                decoration: BoxDecoration(
                  color: Colors.black54, // Black background for input
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10), // Padding inside the input
                child: TextField(
                  style: const TextStyle(color: Colors.white), // White text for input
                  decoration: const InputDecoration(
                    border: InputBorder.none, // No border
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Color.fromARGB(216, 255, 255, 255)), // Hint text color
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space before description

            // Description Heading
            const Text(
              'DESCRIPTION',
              style: TextStyle(
                color: Colors.white, // White text color
                fontSize: 20, // Font size for description heading
                fontWeight: FontWeight.bold, // Bold heading
              ),
            ),
            const SizedBox(height: 10), // Space between heading and input

            // Description Input Field
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of screen
                decoration: BoxDecoration(
                  color: Colors.black54, // Black background for description input
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10), // Padding inside the input
                child: TextField(
                  maxLines: 5, // Allow multiple lines for description
                  style: const TextStyle(color: Colors.white), // White text for input
                  decoration: const InputDecoration(
                    border: InputBorder.none, // No border
                    hintText: 'Enter your description here...',
                    hintStyle: TextStyle(color: Color.fromARGB(216, 255, 255, 255)), // Hint text color
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space before tags section

            // Tags Heading
            const Text(
              'TAGS',
              style: TextStyle(
                color: Colors.white, // White text color
                fontSize: 20, // Font size for tags heading
                fontWeight: FontWeight.bold, // Bold heading
              ),
            ),
            const SizedBox(height: 10), // Space between heading and input

            // Tags Input Field
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of screen
                decoration: BoxDecoration(
                  color: Colors.black54, // Black background for tags input
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10), // Padding inside the input
                child: TextField(
                  style: const TextStyle(color: Colors.white), // White text for input
                  decoration: const InputDecoration(
                    border: InputBorder.none, // No border
                    hintText: 'Enter tags (e.g., #ORPHAN #WIDOW #WAR_VICTIMS)',
                    hintStyle: TextStyle(color: Color.fromARGB(216, 255, 255, 255)), // Hint text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
