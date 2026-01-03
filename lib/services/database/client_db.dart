import 'package:drift/drift.dart';

class ClientDB extends Table{
  IntColumn get id => integer().unique().autoIncrement()();

  TextColumn get name                 => text().unique()();
  TextColumn get identificationNumber => text().nullable().unique().withLength(min: 11, max: 11)();
  TextColumn get phoneNumber          => text().nullable().withLength(min: 8, max: 8)();
}