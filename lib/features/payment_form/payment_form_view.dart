import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/payment_form/view_model/payment_form_cubit.dart';
import 'package:gym/features/payment_form/view_model/payment_form_state.dart';
import 'package:gym/features/payment_form/widgets/expiration_time_picker.dart';
import 'package:gym/features/payment_form/widgets/payment_time_picker.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/payment_repository.dart';


class PaymentFormView extends StatelessWidget{
  const PaymentFormView({
    super.key,
    required this.paymentRepository,
    required this.client
  });

  final PaymentRepository paymentRepository;
  final Client client;

  @override
  Widget build(BuildContext context) {
    final paymentFormCubit =  PaymentFormCubit(client: client, paymentRepository: paymentRepository);
    
    return BlocProvider<PaymentFormCubit>(
      create: (context) => paymentFormCubit,
      
      child: BlocListener<PaymentFormCubit, PaymentFormState>(
        listener: (context, state){
          if(state.paymentFormSubmitionStatus == PaymentFormSubmitionStatus.success){
            Navigator.of(context).pop();
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Nuevo pago registrado"),
                duration: Duration(seconds: 2),
              ),
            );  
          }

        },
        child: AlertDialog(
          title: const Text("Agregar pago                                   "),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                PaymentTimePicker(),
                SizedBox(height: 8,),
                ExpirationTimePicker()
            ],
          ),
          actions: [
            TextButton(onPressed: (){ Navigator.pop(context);}, child: Text("Cancelar")),
            TextButton(
              onPressed: (){
                paymentFormCubit.addPayment();
              }, 
            child: Text("Aceptar"))
          ],
        ),
      ),
    );
  }


}
