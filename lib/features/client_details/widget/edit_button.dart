import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/models/client.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.onEditClient
  });

  final Future<void> Function(BuildContext context, Client client) onEditClient;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // bordes redondeados
        ),
        minimumSize: Size(120, 120), // cuadrado
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow, // color de fondo
      ),
      onPressed: () async {
        final clientDetailsCubit = context.read<ClientDetailsCubit>();
        await onEditClient(context, clientDetailsCubit.state.client);
        clientDetailsCubit.updateClient(); 
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.edit, size: 32, color: Theme.of(context).colorScheme.onSurface), // ícono
          SizedBox(height: 8), // espacio entre ícono y texto
          Text("Editar", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
 
  }

}