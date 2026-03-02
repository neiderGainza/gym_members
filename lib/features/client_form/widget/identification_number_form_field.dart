import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';

class IdentificationNumberFormField extends StatelessWidget {
  const IdentificationNumberFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFormCubit, ClientFormState>(

      builder: (context, state){
        
        return TextFormField(
          initialValue: state.identificationNumber.value,
          onChanged: context.read<ClientFormCubit>().onIdentificationNumberChanged,
          onTapOutside: (event) => context.read<ClientFormCubit>().onIdentificationNumberUnFocus(),
          
          decoration: InputDecoration(
            labelText: "N. Carnet",
            suffixIcon: Icon(Icons.numbers),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide( width: 2),
            ),
            errorStyle: TextStyle(color : Theme.of(context).colorScheme.error),
            errorText: state.identificationNumber.displayError?.message, 
          )
        );
      }
    );
  }
}
