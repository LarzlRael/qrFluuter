
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrapp/src/bloc/scans_bloc.dart';
import 'package:qrapp/src/models/scan_model.dart';
import 'package:qrapp/src/pages/direcciones_page.dart';
import 'package:qrapp/src/pages/mapas_page.dart';

//modulo del barcode_scanner
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrapp/src/utils/utils.dart' as utils;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //metodo para poder cambiar de pagina

  final scanBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Qr Scanner'),
          actions: <Widget>[
            //creando el icono que se muestar a un costa del app bar
            IconButton(
              icon: Icon(Icons.delete_forever),
              // Evento para borrar todos los registros que nos queda
              onPressed: scanBloc.borrarScansTodos,
            ),
          ],
        ),
        body: _callPage(currentIndex),
        bottomNavigationBar: _crearBotonNavigationBar(),

        //ubicando el boton
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //creando el boton
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),

          onPressed: ()=> _scanQR(context),
          
          backgroundColor: Theme.of(context).primaryColor,
        ));
  }

  Widget _crearBotonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      //recibe la posicion del elemente segun el tap que hizo
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        ),
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  _scanQR(BuildContext context) async {
    //este paquete usar la camara y registrar el string

    //geo  = geo:40.690399745185275,-73.94826307734378
    //url  = http://google.com/
    // String futureString = 'http://google.com/';
    // String futureString2 = 'geo:40.690399745185275,-73.94826307734378';
    String futureString = '';
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    // print('Futere String : $futureString');

    if (futureString != null) {
      // print('Tenemos informacion');
      final scan = ScanModel(valor: futureString);

      scanBloc.agregarScan(scan);
      
      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750),(){
          utils.abrirScan(context ,scan);
        });
      }

      utils.abrirScan(context, scan);
    }
  }
}
