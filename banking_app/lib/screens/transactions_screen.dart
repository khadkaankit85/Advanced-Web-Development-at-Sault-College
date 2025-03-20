import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String date;
  final String description;
  final double amount;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'],
      description: json['description'],
      amount: json['amount'].toDouble(),
    );
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Transaction> transactions = [];
  String accountType = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      setState(() {
        accountType = args;
      });
      _loadTransactions();
    });
  }

  Future<void> _loadTransactions() async {
    try {
      final String jsonString =
          await rootBundle.loadString('transactions.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> transactionsList =
          jsonData['transactions'][accountType];

      setState(() {
        transactions =
            transactionsList.map((json) => Transaction.fromJson(json)).toList();
      });
    } catch (e) {
      debugPrint('Error loading transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$accountType Transactions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final isNegative = transaction.amount < 0;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    isNegative ? Colors.red[100] : Colors.green[100],
                child: Icon(
                  isNegative ? Icons.remove : Icons.add,
                  color: isNegative ? Colors.red : Colors.green,
                ),
              ),
              title: Text(
                transaction.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                DateFormat('MMM d, y').format(DateTime.parse(transaction.date)),
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Text(
                '\$${transaction.amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isNegative ? Colors.red : Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
