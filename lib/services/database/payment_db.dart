import 'package:drift/drift.dart';
import 'package:gym/services/database/client_db.dart';

class PaymentDB extends Table{
  IntColumn get id       => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ClientDB, #id)();

  DateTimeColumn get date           => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expirationDate => dateTime()();

}