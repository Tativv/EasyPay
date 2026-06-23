class Money {
  const Money({required this.amount, required this.currency});

  final double amount;
  final String currency;

  String format() {
    final normalized = amount.toStringAsFixed(2).replaceAll('.', ',');
    return currency == 'BRL' ? 'R\$ $normalized' : '$currency $normalized';
  }
}
