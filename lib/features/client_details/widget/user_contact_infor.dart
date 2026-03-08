import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/client_details/view_model/client_details_cubit.dart';
import 'package:gym/features/client_details/view_model/client_details_state.dart';

class UserContactInfor extends StatelessWidget {
  const UserContactInfor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
      builder: (context , state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(state.client.name, style: TextStyle(fontSize: 24),),
            if(state.client.identificationNumber != null)
            Text('CI: ${state.client.identificationNumber!}'),
            if(state.client.phoneNumber != null)
            SelectableText(state.client.phoneNumber!),    
          ],
        ),
      ),
    );
  }
}
