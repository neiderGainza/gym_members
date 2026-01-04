import 'package:drift/drift.dart';
import 'package:gym/models/client.dart';
import 'package:gym/services/database/database.dart';


extension ClientMappers on Client {
  
  ClientDBCompanion toCompanion() {
    return ClientDBCompanion(
      id : id == null ? const Value.absent() : Value(id!),
      name: Value(name),
      identificationNumber: Value(identificationNumber),
      phoneNumber: Value(phoneNumber),
    );
  }

}



extension ClientDataMappers on ClientDBData{
  
  Client toClient(){
    return Client(
      name: name,
       id  : id,
      identificationNumber: identificationNumber,
      phoneNumber: phoneNumber
    );
  }

}