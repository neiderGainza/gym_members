import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/payment_form/view_model/payment_form_cubit.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class PaymentTimePicker extends StatelessWidget {
  const PaymentTimePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Desde: "),
        Expanded(child: TimePickerSpinnerPopUp(
          mode: CupertinoDatePickerMode.date,
          initTime: context.read<PaymentFormCubit>().state.since,
          minTime: DateTime.now().subtract(const Duration(days: 10)),
          maxTime: DateTime.now().add(const Duration(days: 10)),
          barrierColor: Colors.black12, //Barrier Color when pop up show
          minuteInterval: 1,
          padding : const EdgeInsets.fromLTRB(12, 10, 12, 10),
          cancelText : 'Cancel',
          confirmText : 'OK',
          pressType: PressType.singlePress,
          timeFormat: 'dd/MM/yyyy',
          // Customize your time widget
          // timeWidgetBuilder: (dateTime) {},
          onChange: (dateTime) {
            context.read<PaymentFormCubit>().onSinceChanged(dateTime);
          },
        )),
      ],
    );
  }
}
