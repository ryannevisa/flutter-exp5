import 'package:flutter/material.dart';
import 'budget_model.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _incomeCtrl = TextEditingController();
  final _rentCtrl = TextEditingController();
  final _foodCtrl = TextEditingController();
  final _transportCtrl = TextEditingController();
  final _othersCtrl = TextEditingController();

  @override
  void dispose() {
    _incomeCtrl.dispose();
    _rentCtrl.dispose();
    _foodCtrl.dispose();
    _transportCtrl.dispose();
    _othersCtrl.dispose();
    super.dispose();
  }

  String? _validateIncome(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter monthly income';
    final n = double.tryParse(v.trim());
    if (n == null) return 'Enter a valid number';
    if (n <= 0) return 'Income must be a positive value';
    return null;
  }

  String? _validateExpense(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter amount (0 if none)';
    final n = double.tryParse(v.trim());
    if (n == null) return 'Enter a valid number';
    if (n < 0) return 'Amount cannot be negative';
    return null;
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    // read form input and store it as a Budget object
    final budget = Budget(
      income: double.parse(_incomeCtrl.text.trim()),
      rent: double.parse(_rentCtrl.text.trim()),
      food: double.parse(_foodCtrl.text.trim()),
      transport: double.parse(_transportCtrl.text.trim()),
      others: double.parse(_othersCtrl.text.trim()),
    );

    // pass the object to the result screen using arguments
    Navigator.pushNamed(context, '/result', arguments: budget);
  }

  void _reset() {
    _formKey.currentState!.reset();
    _incomeCtrl.clear();
    _rentCtrl.clear();
    _foodCtrl.clear();
    _transportCtrl.clear();
    _othersCtrl.clear();
  }

  Widget _field(String label, IconData icon, TextEditingController ctrl,
    String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Budget'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _field('Monthly Income', Icons.account_balance_wallet,
                    _incomeCtrl, _validateIncome),
                  _field('Rent / EMI', Icons.home, _rentCtrl, _validateExpense),
                  _field('Food Expenses', Icons.restaurant, _foodCtrl,
                    _validateExpense),
                  _field('Transport Expenses', Icons.directions_bus,
                    _transportCtrl, _validateExpense),
                  _field('Other Expenses', Icons.shopping_cart, _othersCtrl,
                    _validateExpense),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: _calculate,
                      child: const Text('CALCULATE >>'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: _reset,
                      child: const Text('RESET'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
