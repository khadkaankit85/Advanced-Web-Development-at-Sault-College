import 'dart:convert'; // Provides JSON encoding and decoding functionality
import 'package:flutter/material.dart'; // Core Flutter UI framework
import 'package:flutter/services.dart'; // For accessing platform features like loading assets
import 'package:intl/intl.dart'; // For date formatting

/// Model class representing a financial transaction
class Transaction {
  final String date; // Date when transaction occurred
  final String description; // Description of the transaction
  final double
      amount; // Transaction amount (positive for deposits, negative for withdrawals)

  // Constructor requiring all fields
  Transaction({
    required this.date,
    required this.description,
    required this.amount,
  });

  // Factory constructor to create Transaction object from JSON data
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'],
      description: json['description'],
      amount: json['amount']
          .toDouble(), // Convert to double in case it comes as int
    );
  }
}

/// Widget that displays the list of transactions for a specific account
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

/// State class for the TransactionsScreen widget
class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Transaction> transactions = []; // Stores the list of transactions
  String accountType =
      ''; // Type of account whose transactions are being displayed

  @override
  void initState() {
    super.initState();
    // Wait until widget is fully built before accessing route arguments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Extract account type from navigation arguments
      final args = ModalRoute.of(context)!.settings.arguments as String;
      setState(() {
        accountType = args;
      });
      _loadTransactions(); // Load transactions for this account type
    });
  }

  /// Loads transaction data from a JSON file
  Future<void> _loadTransactions() async {
    try {
      // Load JSON string from assets
      final String jsonString =
          await rootBundle.loadString('transactions.json');

      // Decode the JSON string to a Map
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Extract the transactions list for the specific account type
      final List<dynamic> transactionsList =
          jsonData['transactions'][accountType];

      // Update the state with the parsed transactions
      setState(() {
        transactions =
            transactionsList.map((json) => Transaction.fromJson(json)).toList();
      });
    } catch (e) {
      // Handle any errors that occur during loading
      debugPrint('Error loading transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with dynamic title based on account type
      appBar: AppBar(
        title: Text('$accountType Transactions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navigate back on press
        ),
      ),
      // List of transactions
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final isNegative = transaction.amount < 0; // Check if it's an expense

          // Card for each transaction with transaction details
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              // Circle avatar with color based on transaction type (income/expense)
              leading: CircleAvatar(
                backgroundColor:
                    isNegative ? Colors.red[100] : Colors.green[100],
                child: Icon(
                  isNegative
                      ? Icons.remove
                      : Icons.add, // Minus icon for expenses, plus for income
                  color: isNegative ? Colors.red : Colors.green,
                ),
              ),
              // Transaction description
              title: Text(
                transaction.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Formatted date
              subtitle: Text(
                DateFormat('MMM d, y').format(DateTime.parse(
                    transaction.date)), // Format date to be more readable
                style: const TextStyle(color: Colors.grey),
              ),
              // Transaction amount with appropriate color
              trailing: Text(
                '\$${transaction.amount.abs().toStringAsFixed(2)}', // Use absolute value and format with 2 decimal places
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isNegative
                      ? Colors.red
                      : Colors.green, // Red for expenses, green for income
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
