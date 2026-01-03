import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gym/exceptions/client_exception.dart';
import 'package:gym/features/client_form/field/field_identification_number.dart';
import 'package:gym/features/client_form/field/field_name.dart';
import 'package:gym/features/client_form/field/field_phone_number.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';

class ClientFormCubit extends Cubit<ClientFormState>{
  final ClientRepository clientRepository;
  
  ClientFormCubit({
    required this.clientRepository
  }): super( 
    ClientFormState(
      name: FieldName.unvalidated(),
      identificationNumber: FieldIdentificationNumber.unvalidated(),
      phoneNumber: FieldPhoneNumber.unvalidated()
    ) 
  );


  void onFieldNameChanged(String newValue){
    emit(
      state.copyWith(
        name: FieldName.unvalidated(newValue)
      )
    );
  }

  void onFieldNameUnFocus() async {
    final name = state.name.value.trim();
    bool isNameAlreadyInUse = await clientRepository.isNameAlreadyInUse(name);
    
    emit(
      state.copyWith(
        name: isNameAlreadyInUse 
              ? FieldName.alreadyInUse(name) 
              : FieldName.validated(name) 
      )      
    );
  }


  void onIdentificationNumberChanged(String newValue){
    emit(
      state.copyWith(
        identificationNumber: FieldIdentificationNumber.unvalidated(newValue)
      )
    );
  }  

  void onIdentificationNumberUnFocus() async {
    final identificationNumber = state.identificationNumber.value.trim();
    bool isIdentificationNumberAlreadyInUse = await clientRepository.isIdentificationAlreadyInUse(identificationNumber);
    
    emit(
      state.copyWith(
        identificationNumber: isIdentificationNumberAlreadyInUse
              ? FieldIdentificationNumber.alreadyInUse(identificationNumber) 
              : FieldIdentificationNumber.validated(identificationNumber) 
      )      
    );
  }

  void onPhoneNumberChanged(String newValue){
    emit(
      state.copyWith(
        phoneNumber: FieldPhoneNumber.unvalidated(newValue)
      )
    );
  }  

  void onPhoneNumberUnFocus(){
    emit(
      state.copyWith(
        phoneNumber: FieldPhoneNumber.validated(state.phoneNumber.value.trim()) 
      )      
    );
  }
  
  

  void onAddClient() async {
    bool isNameAlreadyInUse                 = await clientRepository.isNameAlreadyInUse(state.name.value.trim());
    bool isIdentificationNumberAlreadyInUse = await clientRepository.isIdentificationAlreadyInUse(state.identificationNumber.value.trim());
    
    if(isNameAlreadyInUse) {onFieldNameUnFocus();}
    else if ( isIdentificationNumberAlreadyInUse ) {onIdentificationNumberUnFocus();}
    else{
      final isValid = Formz.validate([
        state.name,
        state.phoneNumber,
        state.identificationNumber
      ]);


      var submitionState = SubmitionState.still;

      if(isValid){        
        try{
          final identificationNumber = (state.identificationNumber.value.trim() != '')
                                       ? state.identificationNumber.value.trim()
                                       : null;
          final phoneNumber          = (state.phoneNumber.value.trim() != '')
                                       ?  state.phoneNumber.value.trim()
                                       : null;

          final client = await clientRepository.addClient(
            Client(
              name: state.name.value.trim(),
              identificationNumber: identificationNumber,
              phoneNumber: phoneNumber
            )
          );
          submitionState = SubmitionState.succes;
        }catch(e){
          submitionState = SubmitionState.failed;
        }
        
      }else{
        submitionState = SubmitionState.failed;
      }

      emit(
        state.copyWith(
          name: FieldName.validated(state.name.value),
          phoneNumber: FieldPhoneNumber.validated(state.phoneNumber.value),
          identificationNumber: FieldIdentificationNumber.validated(state.identificationNumber.value),
          submitionState: submitionState
        )
      );
    }
  }
}