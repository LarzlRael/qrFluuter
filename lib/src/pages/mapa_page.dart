import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qrapp/src/providers/db_providers.dart';
//modulo del paquete de latitud y lng

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = new MapController();

  String tipoMapa = '';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cordendas QR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                map.move(scan.getLang(), 15);
              }),
        ],
      ),
      body: _crearFlutterMap(scan),
      //metodo para poder crear el boton flotante
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLang(), zoom: 15),
      layers: [_crearMapa(), _crearMarcadores(scan)],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoibGFyemRvc2FuIiwiYSI6ImNrN3l6Y2o1aTAwemQzbXB0bnlhMDNlbnAifQ.6-LMuKV8ARlIVucfd3GQnA',
          'id': 'mapbox.$tipoMapa'
          //tipos de mapas
          // streets, dark, light, outdoors, satellite
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLang(),
          builder: (context) => Container(
                child: Icon(Icons.location_on,
                    size: 45.0, color: Theme.of(context).primaryColor),
              ))
    ]);
  }

  Widget _crearBotonFlotante(BuildContext context) {
    print('esto tendria que funcionar');
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      //cuando se aprete va cambiar al siguiente tipo de mapa
      onPressed: () {
// streets, dark, light, outdoors, satellite
        if (tipoMapa == 'streets') {
          tipoMapa = 'dark';
        } else if (tipoMapa == 'dark') {
          tipoMapa = 'light';
        } else if (tipoMapa == 'light') {
          tipoMapa = 'outdoors';
        } else if (tipoMapa == 'outdoors') {
          tipoMapa = 'satellite';
        } else {
          tipoMapa = 'streets';
        }
        setState(() {
          
        });
      },
    );
  }
}
