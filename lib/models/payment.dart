class Payment{
  final int ? id;
  final DateTime date;
  final DateTime expirationDate;

  const Payment({
    this.id,
    required this.date,
    required this.expirationDate
  });
}