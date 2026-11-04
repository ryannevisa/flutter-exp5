import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'result_screen.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly Expense Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const InputScreen(),
        '/result': (context) => const ResultScreen(),
      },
    );
  }
}
