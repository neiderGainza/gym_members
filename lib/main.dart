import 'package:flutter/material.dart';
import 'package:gym/features/client_form/view/client_form_view.dart';
import 'package:gym/features/client_list/client_list_view.dart';
import 'package:gym/reposiotires/client_repository.dart';
import 'package:gym/services/database/database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final database = AppDatabase();

  /// Repositories  
  final clientRepository = ClientRepository(database: database);

  /// Views
  final clientFormView = ClientFormView(clientRepository: clientRepository);
  
  final clientListView = ClientListView( 
    clientRepository: clientRepository,
    onAddNewClient: (context) => showDialog(context: context, builder: (context)=>clientFormView),
  );

  


  /// Run
  runApp(
    MaterialApp(
      title: 'Gym Register',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: clientListView 
    )
  );
}

