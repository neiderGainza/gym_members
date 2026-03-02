import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gym/features/client_form/field/field_identification_number.dart';
import 'package:gym/features/client_form/field/field_name.dart';
import 'package:gym/features/client_form/field/field_phone_number.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';

class ClientFormCubit extends Cubit<ClientFormState>{
  final ClientRepository clientRepository;
  final Client ? client;

  ClientFormCubit({
    required this.clientRepository,
    this.client
  }): super( 
    ClientFormState(
      name: FieldName.unvalidated(),
      identificationNumber: FieldIdentificationNumber.unvalidated(),
      phoneNumber: FieldPhoneNumber.unvalidated()
    ) 
  ){
    if(client != null){
      emit(
        state.copyWith(
          name: FieldName.unvalidated(client!.name),
          identificationNumber: FieldIdentificationNumber.unvalidated(client!.identificationNumber??''),
          phoneNumber: FieldPhoneNumber.unvalidated(client!.phoneNumber ?? '')
        )
      );
    }
  }


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
    
    /// Si esta en uso pero ese uso es por el cliente en edicion , no reportar que esta en uso
    if(isNameAlreadyInUse && client != null && name == client!.name){
      isNameAlreadyInUse = false;
    }

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
    
    /// Si esta en uso pero ese uso es por el cliente en edicion , no reportar que esta en uso
    if(isIdentificationNumberAlreadyInUse 
      && client != null 
      && identificationNumber == client!.identificationNumber){
      isIdentificationNumberAlreadyInUse = false;
    }
    
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
    
    /// Si esta en uso pero ese uso es por el cliente en edicion , no reportar que esta en uso
    if(isIdentificationNumberAlreadyInUse 
      && client != null 
      && state.identificationNumber.value.trim() == client!.identificationNumber){
      isIdentificationNumberAlreadyInUse = false;
    }

    /// Si esta en uso pero ese uso es por el cliente en edicion , no reportar que esta en uso
    if(isNameAlreadyInUse && client != null && state.name.value == client!.name){
      isNameAlreadyInUse = false;
    }
    

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
          if (client == null){
            await clientRepository.addClient(
              Client(
                name: state.name.value.trim(),
                identificationNumber: identificationNumber,
                phoneNumber: phoneNumber
              )
            );
          }else{
            await clientRepository.updateClient(
              Client(
                id: client!.id,
                name: state.name.value.trim(),
                identificationNumber: identificationNumber,
                phoneNumber: phoneNumber
              )
            );
          }
          
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