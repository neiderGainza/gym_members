import 'package:gym/features/client_form/field/field_identification_number.dart';
import 'package:gym/features/client_form/field/field_name.dart';
import 'package:gym/features/client_form/field/field_phone_number.dart';


class ClientFormState {
  final FieldName name;
  final FieldIdentificationNumber identificationNumber;
  final FieldPhoneNumber phoneNumber;
  final SubmitionState submitionState;

  const ClientFormState({
    required this.name,
    required this.identificationNumber,
    required this.phoneNumber,
    this.submitionState = SubmitionState.still
  }); 



  ClientFormState copyWith({
    FieldName ? name , 
    FieldIdentificationNumber ? identificationNumber, 
    FieldPhoneNumber ? phoneNumber,
    SubmitionState ? submitionState
  }){
    return ClientFormState(
      name: name ?? this.name,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      submitionState: submitionState ?? this.submitionState
    );
  }
}




enum SubmitionState{
  still,
  failed,
  succes;
}