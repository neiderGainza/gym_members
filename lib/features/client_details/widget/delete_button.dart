import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/models/client.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final clientDetailsCubit = context.read<ClientDetailsCubit>();   

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // bordes redondeados
        ),
        minimumSize: Size(100, 100), // cuadrado
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow, // color de fondo
      ),
      onPressed: () async {
        final result = await areYouSure(context, context.read<ClientDetailsCubit>().state.client);
        if(result == true){
          clientDetailsCubit.deleteClient();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete, size: 32, color: Theme.of(context).colorScheme.onSurface), // ícono
          SizedBox(height: 8), // espacio entre ícono y texto
          Text("Eliminar", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }


  // Future<void> deleteClient(BuildContext context, Client client) async {
  //   final result = await areYouSure(context, client);
  //   if(result == true){
  //     clientRepository.deleteClient(client);
  //   }
  // }

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

}
