import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/general_list.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/reposiotires/payment_repository.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({
    super.key,
    required this.paymentRepository,
  });

  final PaymentRepository paymentRepository;

  @override
  Widget build(BuildContext context) {
    final clientDetailsCubit = context.read<ClientDetailsCubit>();
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8)
      ),
      child: GeneralList<Payment>(
        itemBuilder: (context, payment){
          return GestureDetector(
            onLongPressStart: (details){
              showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, 0, 0),
                items: [        
                  PopupMenuItem(onTap: () async {
                    final result = await areYouSure(context, payment);
                    if(result == true){
                      await paymentRepository.deletePayment(payment);
                      await clientDetailsCubit.updateClient();
                    }
                  },child: Text("Eliminar")),
                ]
              );
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Fecha de pago:"),
                    trailing: Text(parseDateTime(payment.date), style: TextStyle(fontSize: 16),),
                  ),
                  ListTile(
                    title: const Text("Fecha de expiracion:", ),
                    trailing: Text(parseDateTime(payment.date), style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    title: const Text("Extension del pago:"),
                    trailing: (Text('${getDaysPaid(payment).toString()} días', style: TextStyle(fontSize: 16))),
                  ),
                ],
              ),
            ),
          );
        }, 
        getItems: () => paymentRepository.getPaymentByClient(context.read<ClientDetailsCubit>().state.client),
        noItemsFoundWidget: Align(
          alignment: Alignment.topCenter,
          child: Text("Este cliente no tiene pagos registrados"),
        ),
      ),
    );
  }

  Future<bool?> areYouSure(BuildContext context, Payment payment) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar Pago"),
        content: Text("¿Estás seguro que desea eliminar el pago?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // NO
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // YES
            child: Text("Eliminar", style: TextStyle(color: Theme.of(context).colorScheme.error),),
          ),
        ],
      ),
    );
  }


  int getDaysPaid(Payment payment){
    final timePaid      = payment.expirationDate.difference(payment.date);
    final ajuste        = (timePaid.inHours + timePaid.inMinutes > 0) ? 1:0;
    return timePaid.inDays + ajuste;
  }


  String parseDateTime(DateTime date){
    final paymentDay    = (date.day  < 10)
                          ? '0${date.day}'
                          : '${date.day}';

    final paymentMonth  = (date.month < 10)
                          ? '0${date.month}'
                          : '${date.month}';

    final year          = date.year;

    return '$paymentDay/$paymentMonth/$year';
  }
}
