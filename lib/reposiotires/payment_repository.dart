import 'package:drift/drift.dart';
import 'package:gym/models/client.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/reposiotires/mappers/payment_mappers.dart';
import 'package:gym/services/database/database.dart';

class PaymentRepository {
  final AppDatabase _database;

  PaymentRepository({
    required AppDatabase database
  }) : _database = database;


  Stream<List<Payment>> getPaymentByClient(Client client) async*{
    await for(final paymentDBList in _database.managers.paymentDB.watch()){
      final paymentList = paymentDBList.where(
        (paymentDb) => paymentDb.clientId == client.id
      ).map(
        (paymentDb) => paymentDb.toPayment()
      ).toList();

      paymentList.sort(
        (a, b) => b.expirationDate.compareTo(a.expirationDate)
      );
      yield paymentList;
    }
  } 

  Future<Payment?> addPayment(Payment payment) async{
    assert(payment.id == null);
    final id = await _database.managers.paymentDB.create(
      (f) => payment.toCompanion()
    ) ;  

    final paymentData = await _database.managers.paymentDB.filter((f) => f.id.equals(id)).getSingle();
    return paymentData.toPayment();
  }

  Future<bool> deletePayment(Payment payment) async{
    final result = await _database.managers.paymentDB.filter(
      (f) => f.id.equals(payment.id)
    ).delete();

    return result > 0;
  }

  Future<Payment?> getLastPayment(Client client) async {
    assert(client.id != null);

    final lastPayment = await (_database.select(_database.paymentDB)
      ..where( (p) => p.clientId.equals(client.id!))
      ..orderBy([ (p) => OrderingTerm(expression: p.date, mode: OrderingMode.desc), ])
      ..limit(1)).getSingleOrNull();

    return (lastPayment == null)
          ? null
          : lastPayment.toPayment();  
  }
}