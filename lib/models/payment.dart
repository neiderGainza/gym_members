class Payment{
  final int ? id;
  final int clientId;
  final DateTime date;
  final DateTime expirationDate;
 
  const Payment({
    this.id,
    required this.clientId,
    required this.date,
    required this.expirationDate,
  });
}