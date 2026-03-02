import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';

class NameFormField extends StatelessWidget {
  const NameFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFormCubit, ClientFormState>(
      
      builder: (context, state){
        
        return TextFormField(
          initialValue: state.name.value,
          onChanged: context.read<ClientFormCubit>().onFieldNameChanged,
          onTapOutside: (event) => context.read<ClientFormCubit>().onFieldNameUnFocus(),
          
          decoration: InputDecoration(
            labelText: "Nombre y Apellidos",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide( width: 2),
            ),
          
            errorText: state.name.displayError?.message, 
            
          )
        );
      }
    );
  }
}
