class PaymentFormState {
  final DateTime since;
  final Duration extension; 
  final PaymentFormSubmitionStatus paymentFormSubmitionStatus;

  const PaymentFormState({
    required this.since,
    required this.extension,
    this.paymentFormSubmitionStatus = PaymentFormSubmitionStatus.still
  });


  PaymentFormState copyWith({
    DateTime ? since,
    Duration ? extension,
    PaymentFormSubmitionStatus ? paymentFormSubmitionStatus
  }){
    return PaymentFormState(
      since: since ?? this.since,
      extension: extension ?? this.extension,
      paymentFormSubmitionStatus: paymentFormSubmitionStatus ?? this.paymentFormSubmitionStatus
    );
  }
}



enum PaymentFormSubmitionStatus{
  failed,
  success,
  still;
}







