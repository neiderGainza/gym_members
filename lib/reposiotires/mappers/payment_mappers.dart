import 'package:drift/drift.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/services/database/database.dart';

extension PaymentDBDataMappers on PaymentDBData{
  
  Payment toPayment(){
    return Payment(
      id : id,
      clientId: clientId,
      date: date, 
      expirationDate: expirationDate
    );
  }

}



extension PaymentMappers on Payment {
  
  PaymentDBCompanion toCompanion() {
    return PaymentDBCompanion(
      id : id == null ? const Value.absent() : Value(id!),
      clientId: Value(clientId),
      date: Value(date), 
      expirationDate: Value(expirationDate)
    );
  }

}