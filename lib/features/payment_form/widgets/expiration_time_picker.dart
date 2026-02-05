import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/payment_form/view_model/payment_form_cubit.dart';
import 'package:gym/features/payment_form/view_model/payment_form_state.dart';

class ExpirationTimePicker extends StatelessWidget {
  const ExpirationTimePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final days = PaymentFormCubit.daysThisMonth().inDays;
    
    return Row(
      children: [
        const Text("Hasta: "),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 0.5, color: Theme.of(context).colorScheme.onSecondaryContainer),
              borderRadius: BorderRadius.circular(11)
            ),

            child: BlocBuilder<PaymentFormCubit, PaymentFormState>(
              builder: (context, state) => 
              
              
                DropdownButton<int>(
                  value: state.extension.inDays, 
                  items: [
                    DropdownMenuItem(value: days              , child: Text("  1 mes")),
                    DropdownMenuItem(value: 7                 , child: Text("  1 semana")),
                    DropdownMenuItem(value: 14                , child: Text("  2 semanas")),
                    DropdownMenuItem(value: 1                 , child: Text("  1 dia")),
                    DropdownMenuItem(value: 15                , child: Text("  15 dias")),
                    if(days != 30)
                    DropdownMenuItem(value: 30                , child: Text("  30 dias")),
                    if(days != 31)
                    DropdownMenuItem(value: 31                , child: Text("  31 dias")),
                  ], 
                  
                  onChanged: (newTime){
                    if(newTime != null){
                      context.read<PaymentFormCubit>().onExtensionChanged(Duration(days: newTime));
                    }
                  },
                  icon: SizedBox.shrink(),
                  underline: SizedBox.shrink(),
                  focusColor: Colors.transparent,
                ),


            ),
          )
        )
      ],
    );
  }

}


