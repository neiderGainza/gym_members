import 'package:drift/drift.dart';
import 'package:gym/exceptions/client_exception.dart';
import 'package:gym/models/client.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/services/database/database.dart';

import 'package:gym/reposiotires/mappers/client_mappers.dart';
import 'package:gym/reposiotires/mappers/payment_mappers.dart';


class ClientRepository {
  final AppDatabase _database;

  ClientRepository({
    required AppDatabase database
  }) : _database = database;


  Stream<List<Client>> get clients async*{
    await for (final clientList in _database.managers.clientDB.watch()){
      yield clientList.map(
        (clinetData) => clinetData.toClient()
      ).toList();
    }
  } 


  Future<Client> addClient(Client client) async {
    if ( await isNameAlreadyInUse(client.name)){
      throw UserNameAlreadyExist();
    }
    
    if (  client.identificationNumber != null 
       && await isIdentificationAlreadyInUse(client.identificationNumber!)){
        
      throw IdentificationNumberAlreadyExist();
    }
    
    try{

      final id = await _database.managers.clientDB.create(
        (f) => client.toCompanion()
      );    

      return (await _database.managers.clientDB.filter((f) => f.id.equals(id)).getSingle()).toClient();

    }catch(e){
      throw UnExpectedException();
    }
  }


  Future<bool> isNameAlreadyInUse(String name) async {
    return await _database.managers.clientDB.filter( (f) => f.name.equals( name ) ).exists();
  }

  Future<bool> isIdentificationAlreadyInUse(String identification) async {
    return await _database.managers.clientDB.filter( (f) => f.identificationNumber.equals( identification ) ).exists();
  }


  Future<void> deleteClient(Client client) async{
    _database.managers.clientDB.filter(
      (f) => f.name.equals(client.name)  
    ).delete();
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


  Future<List<Payment>> getPayments(Client client) async {
    assert(client.id != null);

    final payments = await (
      _database.select(_database.paymentDB)
      ..where( (p) => p.clientId.equals(client.id!))
      ..orderBy([ (p) => OrderingTerm(expression: p.date, mode: OrderingMode.desc), ]) 
      ).get();

    return payments.map(
      (paymentDB) => paymentDB.toPayment()
    ).toList();
  }
  
}