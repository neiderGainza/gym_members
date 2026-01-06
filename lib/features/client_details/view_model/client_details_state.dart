import 'package:gym/models/client.dart';
import 'package:gym/models/payment.dart';

class ClientDetailsState {
  final Client client;  
  final Payment ? lastPayment;
  final PaymentCheckState paymentCheckState;
  final bool clientDeleted;

  const ClientDetailsState({
    required this.client,
    this.lastPayment,
    this.paymentCheckState = PaymentCheckState.progress,
    this.clientDeleted = false
  });


  ClientDetailsState copyWith({
    Client ? client,
    Payment ? lastPayment,
    PaymentCheckState ? paymentCheckState,
    bool ? clientDeleted
  }){
    return ClientDetailsState(
      client: client ?? this.client,
      lastPayment: lastPayment ?? this.lastPayment,
      paymentCheckState: paymentCheckState ?? this.paymentCheckState,
      clientDeleted: clientDeleted ?? this.clientDeleted
    );
  }

  ClientDetailsState copyWithLastPaymentNull(){
    return ClientDetailsState(
      client: client,
      lastPayment: null,
      paymentCheckState: PaymentCheckState.finished,
      clientDeleted: clientDeleted
    );
  }
}





enum PaymentCheckState{
  progress,
  finished;
}