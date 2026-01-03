import 'package:formz/formz.dart';

class FieldName extends FormzInput<String, FieldNameError>{
  final bool alreadyInUse;

  const FieldName.unvalidated([String value = '']) : alreadyInUse = false , super.pure(value);
  const FieldName.validated([String value = '']) : alreadyInUse = false, super.dirty(value);
  const FieldName.alreadyInUse([String value = '']) : alreadyInUse = true, super.dirty(value);


  bool _onlyLetters(String texto) { 
    final regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(texto);
  }


  @override
  FieldNameError? validator(String value) {
    return alreadyInUse
      ?FieldNameError.alreadyUsed
      : (value.trim() == '')
        ? FieldNameError.empty
        : !_onlyLetters(value) 
          ? FieldNameError.containSimbol
          : null;
  }

}







enum FieldNameError{
  empty(message: "Nombre requerido"),
  containSimbol(message: "Solo letras"),
  alreadyUsed(message: "Ya registrado")
  ;


  final String message;
  const FieldNameError({
    required this.message
  });
}



