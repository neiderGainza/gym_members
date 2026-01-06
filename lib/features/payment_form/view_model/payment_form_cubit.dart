import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/payment_form/view_model/payment_form_state.dart';
import 'package:gym/models/client.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/reposiotires/payment_repository.dart';

class PaymentFormCubit extends Cubit<PaymentFormState>{
  final Client client;
  final PaymentRepository paymentRepository;


  PaymentFormCubit({
    required this.client,
    required this.paymentRepository
  }): 
  assert(client.id != null),
  super(
    PaymentFormState(since: DateTime.now(), extension: daysThisMonth())
  ){
    loadMinSinceAllowed();
  }

  void loadMinSinceAllowed() async {
    final lastPayment     = await paymentRepository.getLastPayment(client);
    final minSinceAllowed = (lastPayment == null)
                            ? DateTime.now() 
                            : lastPayment.expirationDate;
    
    emit(
      state.copyWith(
        minSinceAllowed: minSinceAllowed,
        since: minSinceAllowed
      )
    );
  }

  void onSinceChanged(DateTime newTime){
    emit(
      state.copyWith(
        since: newTime
      )
    );
  }


  void onExtensionChanged(Duration newDuration){
    emit(
      state.copyWith(
        extension: newDuration
      )
    );
  }


  Future<void> addPayment() async {
    var paymentFormSubmitionStatus = state.paymentFormSubmitionStatus;
    var expirationDate = state.since.add(state.extension);
    expirationDate     =  expirationDate.add(
      -Duration(hours: expirationDate.hour, minutes: expirationDate.minute),
    );

    try{
      paymentRepository.addPayment(
        Payment(
          clientId       : client.id!,
          date           : state.since, 
          expirationDate : expirationDate
        ) 
      );
      
      paymentFormSubmitionStatus = PaymentFormSubmitionStatus.success;
    }catch(_){
      paymentFormSubmitionStatus = PaymentFormSubmitionStatus.failed;
    }
    
    emit(
      state.copyWith(
        paymentFormSubmitionStatus: paymentFormSubmitionStatus
      )
    );
  }
  
  static Duration daysThisMonth(){
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day); 
    
    return DateTime(now.year, now.month + 1, now.day).difference(today);
  }
}