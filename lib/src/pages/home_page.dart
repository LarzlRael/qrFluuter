import 'package:flutter/material.dart';
import 'package:qrapp/src/pages/direcciones_page.dart';
import 'package:qrapp/src/pages/mapas_page.dart';

//modulo del barcode_scanner
import 'package:barcode_scan/barcode_scan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //metodo para poder cambiar de pagina

  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Qr Scanner'),
          actions: <Widget>[
            //creando el icono que se muestar a un costa del app bar
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {},
            ),
          ],
        ),
        body: _callPage(current_index),
        bottomNavigationBar: _crearBotonNavigationBar(),

        //ubicando el boton
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //creando el boton
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),
          onPressed: _scanQR,
          backgroundColor: Theme.of(context).primaryColor,
        ));
  }

  Widget _crearBotonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: current_index,
      //recibe la posicion del elemente segun el tap que hizo
      onTap: (index) {
        setState(() {
          current_index = index;
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

  _scanQR() async {
    //este paquete usar la camara y registrar el string
    //geo  = geo:40.690399745185275,-73.94826307734378
    //h url  = ttp://google.com/
    String futureString = '';
    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }
 
    // print('Futere String : $futureString');

    // if(futureString!=null){
    //   print('Tenemos informacion');
    // }
  }
}
