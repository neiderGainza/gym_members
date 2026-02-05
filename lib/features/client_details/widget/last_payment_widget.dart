import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/features/client_details/view_model/client_details_state.dart';
import 'package:gym/models/payment.dart';

class LastPaymentWidget extends StatelessWidget {
  const LastPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
      builder:(context, state) => ListTile(
        title: const Text("Día de pago: ", style: TextStyle(fontSize: 18),),
        trailing: (state.paymentCheckState == PaymentCheckState.progress)
          ? CircularProgressIndicator()
          : (state.lastPayment == null) 
            ? Icon(CupertinoIcons.exclamationmark_circle, color: Theme.of(context).colorScheme.error,)
            : prepareTextForPayment(state.lastPayment!)
        ,
      ),
    );
  }



  Text prepareTextForPayment(Payment lastPayment){
    final paymentDay    = (lastPayment.expirationDate.day  < 10)
                          ? '0${lastPayment.expirationDate.day}'
                          : '${lastPayment.expirationDate.day}';

    final paymentMonth  = (lastPayment.expirationDate.month < 10)
                          ? '0${lastPayment.expirationDate.month}'
                          : '${lastPayment.expirationDate.month}';

    final timePaid      = lastPayment.expirationDate.difference(DateTime.now());
    final ajuste        = (timePaid.inHours + timePaid.inMinutes > 0) ? 1:0;
    final daysPaid      = timePaid.inDays + ajuste;

    final diference     = (daysPaid > 0)
                          ? '+$daysPaid'
                          : '$daysPaid';

    return Text.rich(
      TextSpan(
        text: '$paymentDay/$paymentMonth ',
        style: TextStyle(
          fontSize: 16
        ),
        children: [
          TextSpan(
            text: '($diference)',
            style: TextStyle(
              color: daysPaid > 0 ? Colors.green : (daysPaid == 0) ? Colors.orange:Colors.red
            )
          )
        ]
      )
    );
    
  }

}
