import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/models/client.dart';

class AddPaymentButton extends StatelessWidget {
  const AddPaymentButton({
    super.key,
    required this.onAddNewPayment
  });

  final Future<void> Function(BuildContext context, Client client) onAddNewPayment;
  
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
        await onAddNewPayment(context, clientDetailsCubit.state.client);
        clientDetailsCubit.updateLastPayment();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.monetization_on, size: 32, color: Theme.of(context).colorScheme.onSurface), // ícono
          SizedBox(height: 8), // espacio entre ícono y texto
          Text("Pagar", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
}
