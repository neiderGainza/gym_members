import 'package:formz/formz.dart';

class FieldIdentificationNumber extends FormzInput<String, FieldIdentificationNumberError>{
  final bool alreadyInUse;

  const FieldIdentificationNumber.unvalidated([String value = '']) : alreadyInUse = false , super.pure(value);
  const FieldIdentificationNumber.validated([String value = '']) : alreadyInUse = false, super.dirty(value);
  const FieldIdentificationNumber.alreadyInUse([String value = '']) : alreadyInUse = true, super.dirty(value);


  bool _onlyNumbers(String texto){ 
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(texto);
  }

  @override
  FieldIdentificationNumberError? validator(String value) {
    return alreadyInUse
      ?FieldIdentificationNumberError.alreadyUsed
      : value != '' && ( !_onlyNumbers(value) || value.length != 11)
          ? FieldIdentificationNumberError.invalid
          : null;
  }

}







enum FieldIdentificationNumberError{
  invalid(message: "Deben de ser 11 dígitos"),
  alreadyUsed(message: "Ya registrado")
  ;


  final String message;
  const FieldIdentificationNumberError({
    required this.message
  });
}



