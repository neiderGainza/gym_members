import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_details/view_model/client_details_state.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';


class ClientDetailsCubit extends Cubit<ClientDetailsState>{
  final ClientRepository clientRepository;
  
  ClientDetailsCubit({
    required this.clientRepository,
    required Client client
  }) : 
  assert(client.id != null),
  super(ClientDetailsState(client: client))
  {    
    loadLastPayment();
  }


  Future<void> updateClient() async{
    final clientUpdated = await clientRepository.getClientById(state.client.id!);
    emit(
      state.copyWith(
        client: clientUpdated
      )
    );
  }


  Future<void> loadLastPayment() async{
    final lastPayment = await clientRepository.getLastPayment(state.client);
    
    if(lastPayment == null){
      emit(
        state.copyWithLastPaymentNull()
      );
    }else{
      emit(
        state.copyWith(
          lastPayment: lastPayment,
          paymentCheckState: PaymentCheckState.finished
        )
      );
    }
  }

  Future<void> updateLastPayment() async {
    emit(
      state.copyWith(
        paymentCheckState: PaymentCheckState.progress
      )
    );

    loadLastPayment();
  }


  Future<void> deleteClient() async {
    try{
      await clientRepository.deleteClient(state.client);
      emit(
        state.copyWith(
          clientDeleted: true
        )
      );
    } catch(_){}
  }

}