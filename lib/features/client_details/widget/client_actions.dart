import 'package:flutter/cupertino.dart';
import 'package:gym/features/client_details/widget/add_payment_button.dart';
import 'package:gym/features/client_details/widget/delete_button.dart';
import 'package:gym/features/client_details/widget/edit_button.dart';
import 'package:gym/models/client.dart';

class ClientActions extends StatelessWidget {
  const ClientActions({
    super.key,
    required this.onAddNewPayment,
    required this.onEditClient
  });

  final Future<void> Function(BuildContext context, Client client) onAddNewPayment;
  final Future<void> Function(BuildContext context, Client client) onEditClient;


  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10
      ),
      shrinkWrap: true,
      children: [
        EditButton(onEditClient: onEditClient,),
        AddPaymentButton(onAddNewPayment: onAddNewPayment,),
        DeleteButton()
      ],     
    );
  }
}
