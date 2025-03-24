import 'package:flutter/material.dart'; // Core Flutter UI framework
import 'package:intl/intl.dart'; // For date formatting

/// Welcome screen widget that serves as the app's landing page
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current date and format it
    final today = DateTime.now();
    final formattedDate = DateFormat('MMMM d, y')
        .format(today); // Format date as "Month Day, Year"

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding around all content
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              // Bank icon
              const Icon(
                Icons.account_balance,
                size: 100,
                color: Colors.red, // Bank brand color
              ),
              const SizedBox(height: 20), // Vertical spacing

              // Welcome text
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Bank name with branded styling
              const Text(
                'Scotia Bank',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Bank brand color
                ),
              ),
              const SizedBox(height: 20), // Vertical spacing

              // Display current date
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey, // Subtle color for date
                ),
              ),
              const SizedBox(
                  height: 40), // Larger vertical spacing before button

              // Button to navigate to accounts screen
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/accounts'); // Navigate to accounts route
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40, // Wider horizontal padding for button
                    vertical: 15, // Taller button
                  ),
                ),
                child: const Text(
                  'View Accounts',
                  style: TextStyle(fontSize: 18), // Larger text for button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
