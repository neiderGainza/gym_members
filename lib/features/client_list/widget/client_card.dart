import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_list/view_model/client_item_cubit.dart';
import 'package:gym/features/client_list/view_model/client_item_state.dart';
import 'package:gym/models/client.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/reposiotires/client_repository.dart';

class ClientCard extends StatelessWidget{
  const ClientCard({
    super.key,
    required this.clientRepository,
    required this.client,
    required this.onAddNewPayment,
    required this.onEditClient
  });

  final ClientRepository clientRepository;
  final Future<void> Function(BuildContext context, Client client) onAddNewPayment;
  final Future<void> Function(BuildContext context, Client client) onEditClient;
  final Client client;

  @override
  Widget build(BuildContext context) {
    final clientItemCubit = ClientItemCubit(clientRepository: clientRepository, client: client); 

    return BlocBuilder<ClientItemCubit, ClientItemState>(
      bloc: clientItemCubit,

      builder:(context, state) => GestureDetector(
        onLongPressStart: (details){
          showMenu<int>(
            context: context,
            position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, 0, 0),
            items: [
              
              PopupMenuItem(onTap: () async {
                await onAddNewPayment(context, client);
                clientItemCubit.updateLastPayment();
              }, child: Text("Agregar Pago"), ), 
              
              PopupMenuItem(onTap: () async {
                await onEditClient(context,client);

              }, child: Text("Editar"), ), 
              
              PopupMenuItem(onTap: () => deleteClient(context, client),child: Text("Eliminar")),
            ]
          );
        },

        child: Card(
          child: ListTile(
            title: Text(client.name),
            subtitle: Text(client.identificationNumber ?? ''),
            trailing: (state.paymentCheckState == PaymentCheckState.progress)
              ? CircularProgressIndicator()
              : (state.lastPayment == null) 
                ? Icon(CupertinoIcons.exclamationmark_circle, color: Theme.of(context).colorScheme.error,)
                : prepareTextForPayment(state.lastPayment!)
            ,
          ),
        ),
      )
    );
  }




  Future<void> deleteClient(BuildContext context, Client client) async {
    final result = await areYouSure(context, client);
    if(result == true){
      clientRepository.deleteClient(client);
    }
  }

  Future<bool?> areYouSure(BuildContext context, Client client) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar Cliente"),
        content: Text("¿Estás seguro que desea eliminar al cliente: ${client.name}?"),
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


  Text prepareTextForPayment(Payment lastPayment){
    final paymentDay    = (lastPayment.expirationDate.day  < 10)
                          ? '0${lastPayment.expirationDate.day}'
                          : '${lastPayment.expirationDate.day}';

    final paymentMonth  = (lastPayment.expirationDate.month < 10)
                          ? '0${lastPayment.expirationDate.month}'
                          : '${lastPayment.expirationDate.month}';

    final diference     = ( lastPayment.expirationDate.difference(DateTime.now()).inDays + 1 > 0)
                          ? '+${lastPayment.expirationDate.difference(DateTime.now()).inDays + 1}'
                          : '${lastPayment.expirationDate.difference(DateTime.now()).inDays + 1}';

    final isPositive    = lastPayment.expirationDate.difference(DateTime.now()).inDays + 1> 0;

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
              color: isPositive ? Colors.green : Colors.red
            )
          )
        ]
      )
    );
    
  }
  
}