class Budget {
  final double income;
  final double rent;
  final double food;
  final double transport;
  final double others;

  const Budget({
    required this.income,
    required this.rent,
    required this.food,
    required this.transport,
    required this.others,
  });

  double get totalExpenses => rent + food + transport + others;

  // Remaining Balance = Income - (Rent + Food + Transport + Others)
  double get balance => income - totalExpenses;
}
