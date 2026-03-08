import 'package:flutter/material.dart';
import 'package:gym/features/client_details/client_details_view.dart';
import 'package:gym/features/client_form/view/client_form_view.dart';
import 'package:gym/features/client_list/client_list_view.dart';
import 'package:gym/features/payment_form/payment_form_view.dart';
import 'package:gym/reposiotires/client_repository.dart';
import 'package:gym/reposiotires/payment_repository.dart';
import 'package:gym/services/database/database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final database = AppDatabase();

  /// Repositories  
  final clientRepository = ClientRepository(database: database);

  final paymentRepository = PaymentRepository(database: database);

  /// Views
  final clientFormView = ClientFormView(clientRepository: clientRepository);

  
  final clientListView = ClientListView( 
    clientRepository: clientRepository,
    
    onAddNewClient: (context) => showDialog(
      context: context, 
      builder: (context)=>clientFormView
    ),
    onEditClient: (context, client) => showDialog(
      context: context, 
      builder: (context)=>ClientFormView(clientRepository: clientRepository, client: client,)
    ),
    onAddNewPayment: (context, client) async => showDialog(
      context: context, 
      builder: (context)=>PaymentFormView(paymentRepository: paymentRepository, client: client)
    ),

    onClientDetailsView: (context, client) async => await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => ClientDetailsView(
          clientRepository: clientRepository, 
          paymentRepository: paymentRepository,
          client: client,
          
          onEditClient: (context, client) => showDialog(
            context: context, 
            builder: (context)=>ClientFormView(clientRepository: clientRepository, client: client,)
          ),
          onAddNewPayment: (context, client) async => showDialog(
            context: context, 
            builder: (context)=>PaymentFormView(paymentRepository: paymentRepository, client: client)
          ),
        )
      )
    ),
  );


  /// Run
  runApp(
    MaterialApp(
      title: 'Gym Members',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
      ),

      home: clientListView 
    )
  );
}

