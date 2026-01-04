import 'package:gym/models/payment.dart';

class ClientItemState {
  final Payment ? lastPayment;
  final PaymentCheckState paymentCheckState;

  const ClientItemState({
    this.lastPayment,
    this.paymentCheckState = PaymentCheckState.progress
  });

  ClientItemState copyWith({
    Payment ? lastPayment,
    PaymentCheckState ? paymentCheckState
  }){
    return ClientItemState(
      lastPayment: lastPayment ?? this.lastPayment,
      paymentCheckState: paymentCheckState ?? this.paymentCheckState
    );
  }
}



enum PaymentCheckState{
  progress,
  finished;
}