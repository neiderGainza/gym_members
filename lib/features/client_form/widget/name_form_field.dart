import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';

class NameFormField extends StatefulWidget {
  const NameFormField({
    super.key,
  });

  @override
  State<NameFormField> createState() => _NameFormFieldState();
}


class _NameFormFieldState extends State<NameFormField> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFormCubit, ClientFormState>(

      builder: (context, state) => TextFormField(
        controller: textEditingController,
        
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
      ),
    );
  }
}
