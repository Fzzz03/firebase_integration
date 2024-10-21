import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_integration/zakat_login_page.dart'; // Make sure this path matches your login page or main widget

void main() {
  testWidgets('Zakat app login button tap test', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      const MaterialApp(
        home: ZakatLoginPage(role: 'user'), // Test your login page or other page
      ),
    );

    
    expect(find.byType(TextField), findsNWidgets(2)); // Checking for 2 input fields (email and password)
    expect(find.text('Login'), findsOneWidget); // Check if the "Login" button exists

    // Tap the 'Login' button and trigger a frame.
    await tester.tap(find.text('Login')); // Tap the "Login" button
    await tester.pump();

      
    // expect(find.text('Welcome to Zakat App'), findsOneWidget); // Example: Verify navigation to a home page with welcome text
  });
}
