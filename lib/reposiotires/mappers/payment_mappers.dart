import 'package:gym/models/payment.dart';
import 'package:gym/services/database/database.dart';

extension PaymentDBDataMappers on PaymentDBData{
  
  Payment toPayment(){
    return Payment(
      id : id,
      date: date, 
      expirationDate: expirationDate
    );
  }

}