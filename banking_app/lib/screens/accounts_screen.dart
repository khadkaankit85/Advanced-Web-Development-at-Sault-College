import 'dart:convert'; // Provides JSON encoding and decoding
import 'package:flutter/material.dart'; // Core Flutter UI framework
import 'package:flutter/services.dart'; // Access to platform functionality like asset loading

/// Model class representing a bank account
class Account {
  final String type; // Type of account (e.g., "Chequing", "Savings")
  final String accountNumber; // Account identifier
  final double balance; // Current account balance

  // Constructor requiring all fields
  Account({
    required this.type,
    required this.accountNumber,
    required this.balance,
  });

  // Factory constructor to create Account from JSON data
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      type: json['type'],
      accountNumber: json['account_number'],
      balance: json['balance']
          .toDouble(), // Convert to double in case it comes as int
    );
  }
}

/// Widget that displays the list of accounts
class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

/// State class for the AccountsScreen widget
class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> accounts = []; // Stores the list of accounts
  bool isLoading = true; // Tracks loading state for UI feedback

  @override
  void initState() {
    super.initState();
    _loadAccounts(); // Load accounts when widget initializes
  }

  /// Loads account data from a JSON file in assets
  Future<void> _loadAccounts() async {
    try {
      // Load JSON string from assets
      final String jsonString =
          await rootBundle.loadString('assets/accounts.json');

      // Decode the JSON string to a Map
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Extract the accounts list from the JSON data
      final List<dynamic> accountsList = jsonData['accounts'];

      // Update the state with the parsed accounts and set loading to false
      setState(() {
        accounts = accountsList.map((json) => Account.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      // Handle any errors that occur during loading
      debugPrint('Error loading accounts: $e');
      setState(() {
        isLoading = false; // Update loading state even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title and back button
      appBar: AppBar(
        title: const Text('My Accounts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navigate back on press
        ),
      ),
      // Body content with conditional rendering based on loading state
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : accounts.isEmpty
              ? const Center(
                  child:
                      Text('No accounts found')) // Show message if no accounts
              : ListView.builder(
                  // Build list of accounts
                  padding: const EdgeInsets.all(16),
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    // Card for each account with account details
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        // Icon based on account type
                        leading: Icon(
                          account.type == 'Chequing'
                              ? Icons.account_balance // Bank icon for chequing
                              : Icons.savings, // Savings icon for other types
                          color: Colors.blue,
                          size: 40,
                        ),
                        // Account type as title
                        title: Text(
                          account.type,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle:
                            Text(account.accountNumber), // Show account number
                        // Display formatted balance amount
                        trailing: Text(
                          '\$${account.balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Navigate to transactions screen when account is tapped
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/transactions',
                            arguments:
                                account.type, // Pass account type as argument
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
