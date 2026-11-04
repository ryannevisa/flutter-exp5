import 'package:flutter/material.dart';
import 'budget_model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _money(double v) =>
    v < 0 ? '-₹${(-v).toStringAsFixed(2)}' : '₹${v.toStringAsFixed(2)}';

  Widget _row(IconData icon, String label, double value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: Text(
        _money(value),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reading data from the previous screen
    final budget = ModalRoute.of(context)!.settings.arguments as Budget;

    final double balance = budget.balance;
    final bool overspending = balance < 0;
    final MaterialColor color = overspending ? Colors.red : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Summary'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Column(
                children: [
                  _row(Icons.account_balance_wallet, 'Monthly Income',
                    budget.income),
                  _row(Icons.home, 'Rent / EMI', budget.rent),
                  _row(Icons.restaurant, 'Food Expenses', budget.food),
                  _row(Icons.directions_bus, 'Transport Expenses',
                    budget.transport),
                  _row(Icons.shopping_cart, 'Other Expenses', budget.others),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 5,
              color: color.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      overspending
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle,
                      color: color,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    const Text('Remaining Balance',
                      style: TextStyle(fontSize: 16)),
                    Text(
                      _money(balance),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      overspending
                        ? 'You are overspending!'
                        : 'Great! You are within your budget.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
