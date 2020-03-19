import 'package:flutter/material.dart';
import 'package:qrapp/src/bloc/scans_bloc.dart';
import 'package:qrapp/src/models/scan_model.dart';

import 'package:qrapp/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    // usando un stream para el metodo 
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scanStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(child: Text('No hay informacion'));
        }
        return ListView.builder(
            itemCount: scans.length,
            // el dismisible es para que cada widget saw deslizable a ambos lados
            itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) =>
                    //lamando al metodo para eliminar desde el stream
                    // DBProvider.db.deleteScan(scans[i].id),
                    scansBloc.borrarScan(scans[i].id),
                child: ListTile(
                  leading: Icon(
                    Icons.cloud_queue,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[i].valor),
                  subtitle: Text('ID ${scans[i].id}'),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      onTap: ()=>utils.abrirScan(context,scans[i]),
                )));
      },
    );
  }
}
