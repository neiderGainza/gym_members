import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:general_list/general_list.dart';
import 'package:gym/features/client_list/widget/client_card.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';


class ClientListView extends StatelessWidget{
  const ClientListView({
    super.key,
    required this.clientRepository,
    required this.onAddNewClient,
    required this.onAddNewPayment,
    required this.onEditClient,
    required this.onClientDetailsView
  });


  final ClientRepository clientRepository;
  final void Function(BuildContext context) onAddNewClient;
  final Future<void> Function(BuildContext context, Client client) onAddNewPayment;
  final Future<void> Function(BuildContext context, Client client) onEditClient;
  final Future<void> Function(BuildContext context, Client client) onClientDetailsView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Members", style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),),
        // actions: [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        // ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      

      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddNewClient(context),
        child: Icon(Icons.add),
      ),


      body: GeneralList<Client>(

        itemBuilder: (context, client){
          return ClientCard(
            clientRepository: clientRepository, 
            client: client, 
            onAddNewPayment: onAddNewPayment,
            onEditClient: onEditClient,
            onClientDetailsView: onClientDetailsView,
          );
        }, 

        getItems: () => clientRepository.clients,

        noItemsFoundWidget: const Center( child: Text('No hay clientes'), ),


        orderChoices: [
          (order: (Client a , Client b) => a.name.compareTo(b.name), label: "Nombre"),
          (order: compareIdentificationNumber, label: "N. Carnet"),
        ],

        filterWidgets: [
          SingleSelectionFilterWidget(
            choices: [
              (filter: (Client a) async => (await clientRepository.isClientInD(a)) ?? false, label: "Deudores"),
              (filter: (Client a) async => !((await clientRepository.isClientInD(a)) ?? true), label: "En regla"),   
              (filter: (Client a) async => await clientRepository.isClientInD(a) == null, label: "Sin pagos registrados"),   
            ], 
            title: "Filtrar por estado de pago"
          )
        ],
        searchFunction: (item, serachTerm){
          final search = Fuzzy([item.name, item.identificationNumber, item.phoneNumber]).search(serachTerm);
          return search.isNotEmpty;
        },
      ),
    );
  }

  int compareIdentificationNumber(Client a , Client b){
    if (a.identificationNumber == null) return -1;
    if (b.identificationNumber == null) return 1;
    return a.identificationNumber!.compareTo(b.identificationNumber!);
  }
}
