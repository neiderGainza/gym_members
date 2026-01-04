import 'package:gym/models/payment.dart';
import 'package:gym/reposiotires/mappers/payment_mappers.dart';
import 'package:gym/services/database/database.dart';

class PaymentRepository {
  final AppDatabase _database;

  PaymentRepository({
    required AppDatabase database
  }) : _database = database;


  Future<Payment?> addPayment(Payment payment) async{
    assert(payment.id == null);
    final id = await _database.managers.paymentDB.create(
      (f) => payment.toCompanion()
    ) ;  

    final paymentData = await _database.managers.paymentDB.filter((f) => f.id.equals(id)).getSingle();
    return paymentData.toPayment();
  }

}