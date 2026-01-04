import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_list/view_model/client_item_state.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';

class ClientItemCubit extends Cubit<ClientItemState>{
  final ClientRepository clientRepository;
  final Client client;

  ClientItemCubit({
    required this.clientRepository,
    required this.client
  }) : super(ClientItemState())
  {
    loadLastPayment();
  }


  Future<void> loadLastPayment() async{
    final lastPayment = await clientRepository.getLastPayment(client);
    emit(
      state.copyWith(
        lastPayment: lastPayment,
        paymentCheckState: PaymentCheckState.finished
      )
    );
  }

  Future<void> updateLastPayment() async {
    emit(
      state.copyWith(
        paymentCheckState: PaymentCheckState.progress
      )
    );

    loadLastPayment();
  }

}