import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_form/view_model/client_form_cubit.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      context.read<ClientFormCubit>().onAddClient();
    }, child: Text("Aceptar"));
  }
}
