import 'package:flutter/material.dart'; // Core Flutter UI framework
import 'screens/welcome_screen.dart'; // Import the welcome screen widget
import 'screens/accounts_screen.dart'; // Import the accounts screen widget
import 'screens/transactions_screen.dart'; // Import the transactions screen widget

/// Entry point of the application
void main() {
  runApp(const BankingApp()); // Initialize and run the app
}

/// Root widget that configures the application
class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App', // App title used in task switchers
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color for the app
        useMaterial3: true, // Enable Material 3 design system
      ),
      initialRoute: '/', // Set initial route to welcome screen
      routes: {
        // Define navigation routes for the app
        '/': (context) =>
            const WelcomeScreen(), // Root route shows welcome screen
        '/accounts': (context) =>
            const AccountsScreen(), // Route to view accounts
        '/transactions': (context) =>
            const TransactionsScreen(), // Route to view transactions
      },
    );
  }
}
