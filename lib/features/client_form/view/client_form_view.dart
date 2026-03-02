import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';
import 'package:gym/features/client_form/widget/accept_button.dart';
import 'package:gym/features/client_form/widget/cancel_button.dart';
import 'package:gym/features/client_form/widget/identification_number_form_field.dart';
import 'package:gym/features/client_form/widget/name_form_field.dart';
import 'package:gym/features/client_form/widget/phone_number_form_field.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';



class ClientFormView extends StatelessWidget {
  const ClientFormView({
    super.key,
    required this.clientRepository,
    this.client
  });

  final ClientRepository clientRepository;
  final Client ? client;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientFormCubit>( 
      create: (context) => ClientFormCubit(clientRepository: clientRepository, client: client),


      child: BlocListener<ClientFormCubit, ClientFormState>(
        listener: (context, state){
          if(state.submitionState == SubmitionState.succes){
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: (client == null) ? Text("Nuevo Cliente Registrado") : Text("Cliente Editado"),
                duration: Duration(seconds: 2),
              ),
            );  
          }
        },
        child: AlertDialog(
          title: (client == null) 
          ?Text("Agregar nuevo miembro                       ")
          :Text("Editar informacion del cliente              ")
          ,
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NameFormField(),
                SizedBox(height: 8,),
                IdentificationNumberFormField(),
                SizedBox(height: 8,),
                PhoneNumberFormField(),
              ]
            ),
          ),
  
          actions: [
            CancelButton(),
            AcceptButton()
          ],
        ),
      ) 
    );  
  }
}



