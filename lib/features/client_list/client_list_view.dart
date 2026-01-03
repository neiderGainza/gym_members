import 'package:flutter/material.dart';
import 'package:general_list/general_list.dart';
import 'package:gym/models/client.dart';
import 'package:gym/reposiotires/client_repository.dart';

class ClientListView extends StatelessWidget{
  const ClientListView({
    super.key,
    required this.clientRepository,
    required this.onAddNewClient
  });

  final ClientRepository clientRepository;
  final void Function(BuildContext context) onAddNewClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Members", style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddNewClient(context),
        child: Icon(Icons.add),
      ),


      body: GeneralList<Client>(

        itemBuilder: (context, client){
          return GestureDetector(
            onLongPressStart: (details){
              showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, 0, 0),
                items: [
                  PopupMenuItem(child: Text("Agregar Pago"), ), 
                  PopupMenuItem(child: Text("Editar"), ), 
                  PopupMenuItem(onTap: () => deleteClient(context, client),child: Text("Eliminar")),
                
                ]
              );
            },

            child: Card(
              child: ListTile(
                title: Text(client.name),
                subtitle: Text(client.identificationNumber ?? ''),
                
              ),
            ),
          );
        }, 


        getItems: () => clientRepository.clients,


        noItemsFoundWidget: Center(
          child: Text('No hay clientes'),
        ),


        // orderChoices: [
        //   (order: (Client a , Client b) => a.name.compareTo(b.name), label: "Nombre"),
        //   (order: (Client a , Client b) => a.name.compareTo(b.name), label: "N. Carnet"),
        //   (order: (Client a , Client b) => a.name.compareTo(b.name), label: "Tiempo Pagado"),          
        // ],

        // filterWidgets: [
        //   MultipleSelectionFilterWidget(
        //     choices: [
        //       (filter: (Client a) async => true, label: "Hola")
        //     ], 
        //     title: "Filtros"
        //   )
        // ],
      ),
    );
  }


  Future<void> deleteClient(BuildContext context, Client client) async {
    final result = await areYouSure(context, client);
    if(result == true){
      clientRepository.deleteClient(client);
    }
  }

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