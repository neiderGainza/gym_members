import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/general_list.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/features/client_details/view_model/client_details_state.dart';
import 'package:gym/features/client_details/widget/client_actions.dart';
import 'package:gym/features/client_details/widget/last_payment_widget.dart';
import 'package:gym/features/client_details/widget/payment_list.dart';
import 'package:gym/features/client_details/widget/user_contact_infor.dart';
import 'package:gym/models/client.dart';
import 'package:gym/models/payment.dart';
import 'package:gym/reposiotires/client_repository.dart';
import 'package:gym/reposiotires/payment_repository.dart';



class ClientDetailsView extends StatelessWidget{
  const ClientDetailsView({
    super.key,
    required this.clientRepository,
    required this.paymentRepository,
    required this.client,

    required this.onAddNewPayment,
    required this.onEditClient
  });

  final PaymentRepository paymentRepository;
  final ClientRepository clientRepository;
  final Client client;

  final Future<void> Function(BuildContext context, Client client) onAddNewPayment;
  final Future<void> Function(BuildContext context, Client client) onEditClient;
  

  @override
  Widget build(BuildContext context) {
    final clientDetailsCubit = ClientDetailsCubit(clientRepository: clientRepository, client: client);
    
    return BlocProvider<ClientDetailsCubit>.value(
      value: clientDetailsCubit,
      child: BlocConsumer<ClientDetailsCubit, ClientDetailsState>(
        bloc: clientDetailsCubit,

        listener: (context, state) {
          if(state.clientDeleted){
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("El cliente ha sido eliminado"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },

        builder: (context, state) {
          return Scaffold(
 
            appBar: AppBar(
              title: Text("Detalles de cliente"),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
 
            body: Column(
              children: [
                (MediaQuery.of(context).size.width > 600)
                ? desktopHeader(context)
                : mobileHeader(context),
                
                Expanded(
                  child: PaymentList(paymentRepository: paymentRepository)
                )
              ],  
            ),
          );   
        },
      )
    );
  }



  Widget mobileHeader(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [                        
          UserContactInfor(),
          ClientActions(
            onAddNewPayment: onAddNewPayment,
            onEditClient: onEditClient,
          ),
          const SizedBox(height: 8,),
          LastPaymentWidget()
        ],
      ),
    );
  }
  
  Widget desktopHeader(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [                        
          UserContactInfor(),
          ClientActions(
            onAddNewPayment: onAddNewPayment,
            onEditClient: onEditClient,
          ),
          const SizedBox(height: 8,),
          LastPaymentWidget()
        ],
      ),
    );
  }
  
}
