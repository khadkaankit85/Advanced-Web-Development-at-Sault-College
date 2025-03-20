import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/accounts_screen.dart';
import 'screens/transactions_screen.dart';

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/accounts': (context) => const AccountsScreen(),
        '/transactions': (context) => const TransactionsScreen(),
      },
    );
  }
}
