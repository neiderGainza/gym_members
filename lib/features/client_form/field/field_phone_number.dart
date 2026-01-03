import 'package:formz/formz.dart';

class FieldPhoneNumber extends FormzInput<String, FieldPhoneNumberError>{
 
  const FieldPhoneNumber.unvalidated([String value = '']) : super.pure(value);
  const FieldPhoneNumber.validated([String value = '']) : super.dirty(value);
 
  
  bool _onlyNumbers(String texto){ 
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(texto);
  }


  @override
  FieldPhoneNumberError? validator(String value) {
    return value == '' || (_onlyNumbers(value) && value.length == 8)
          ? null 
          : FieldPhoneNumberError.invalid;
  }

}







enum FieldPhoneNumberError{
  invalid(message: "Deben ser 8 dígitos"),
  ;


  final String message;
  const FieldPhoneNumberError({
    required this.message
  });
}



