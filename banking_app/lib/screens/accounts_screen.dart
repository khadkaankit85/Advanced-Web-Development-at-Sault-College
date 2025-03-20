import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Account {
  final String type;
  final String accountNumber;
  final double balance;

  Account({
    required this.type,
    required this.accountNumber,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      type: json['type'],
      accountNumber: json['account_number'],
      balance: json['balance'].toDouble(),
    );
  }
}

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> accounts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/accounts.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> accountsList = jsonData['accounts'];

      setState(() {
        accounts = accountsList.map((json) => Account.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading accounts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accounts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : accounts.isEmpty
              ? const Center(child: Text('No accounts found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: Icon(
                          account.type == 'Chequing'
                              ? Icons.account_balance
                              : Icons.savings,
                          color: Colors.blue,
                          size: 40,
                        ),
                        title: Text(
                          account.type,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(account.accountNumber),
                        trailing: Text(
                          '\$${account.balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/transactions',
                            arguments: account.type,
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
