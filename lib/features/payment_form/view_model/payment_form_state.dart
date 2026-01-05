class PaymentFormState {
  final DateTime since;
  final Duration extension; 
  
  final DateTime ? minSinceAllowed;
  final PaymentFormSubmitionStatus paymentFormSubmitionStatus;

  const PaymentFormState({
    required this.since,
    required this.extension,
    this.minSinceAllowed,
    this.paymentFormSubmitionStatus = PaymentFormSubmitionStatus.still
  });


  PaymentFormState copyWith({
    DateTime ? since,
    DateTime ? minSinceAllowed,
    Duration ? extension,
    PaymentFormSubmitionStatus ? paymentFormSubmitionStatus
  }){
    return PaymentFormState(
      since: since ?? this.since,
      extension: extension ?? this.extension,
      paymentFormSubmitionStatus: paymentFormSubmitionStatus ?? this.paymentFormSubmitionStatus,
      minSinceAllowed: minSinceAllowed ?? this.minSinceAllowed
    );
  }
}



enum PaymentFormSubmitionStatus{
  failed,
  success,
  still;
}







