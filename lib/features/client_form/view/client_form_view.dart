import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';
import 'package:gym/features/client_form/widget/accept_button.dart';
import 'package:gym/features/client_form/widget/cancel_button.dart';
import 'package:gym/features/client_form/widget/identification_number_form_field.dart';
import 'package:gym/features/client_form/widget/name_form_field.dart';
import 'package:gym/features/client_form/widget/phone_number_form_field.dart';
import 'package:gym/reposiotires/client_repository.dart';



class ClientFormView extends StatelessWidget {
  const ClientFormView({
    super.key,
    required this.clientRepository
  });

  final ClientRepository clientRepository;


  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientFormCubit>( 
      create: (context) => ClientFormCubit(clientRepository: clientRepository),


      child: BlocListener<ClientFormCubit, ClientFormState>(
        listener: (context, state){
          if(state.submitionState == SubmitionState.succes){
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Nuevo Cliente Registrado"),
                duration: Duration(seconds: 2),
              ),
            );  
          }
        },
        child: AlertDialog(
          title: Text("Agregar nuevo miembro"),

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



