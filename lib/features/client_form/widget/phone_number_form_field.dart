import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';
import 'package:gym/features/client_form/view_model/client_form_state.dart';

class PhoneNumberFormField extends StatefulWidget {
  const PhoneNumberFormField({
    super.key,
  });

  @override
  State<PhoneNumberFormField> createState() => _NameFormFieldState();
}


class _NameFormFieldState extends State<PhoneNumberFormField> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFormCubit, ClientFormState>(

      builder: (context, state) => TextFormField(
        controller: textEditingController,
        
        onChanged: context.read<ClientFormCubit>().onPhoneNumberChanged,
        onTapOutside: (event) => context.read<ClientFormCubit>().onPhoneNumberUnFocus(),
        
        decoration: InputDecoration(
          labelText: "Celular",
          suffixIcon: Icon(Icons.numbers),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide( width: 2),
          ),
          errorStyle: TextStyle(color : Theme.of(context).colorScheme.error),
          errorText: state.phoneNumber.displayError?.message, 
        )
      ),
    );
  }
}
