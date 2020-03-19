import 'dart:async';

import 'package:qrapp/src/bloc/validators.dart';
import 'package:qrapp/src/providers/db_providers.dart';

//en esta clase vamos a hereddar de la otra clase validators
class ScansBloc with Validators {
  static final ScansBloc _sigleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _sigleton;
  }

  ScansBloc._internal() {
    // Otener Scans de la base de datos usando nuestro metodo de obtener scan
    obtenerScans();
  }

  final _scansConstroller = StreamController<List<ScanModel>>.broadcast();

  // metodo para que fluja nuestra informacion
  Stream<List<ScanModel>> get scanStream => _scansConstroller.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scanStreamHttp => _scansConstroller.stream.transform(validarHttp);

  dispose() {
    _scansConstroller?.close();
  }

  //metodo para agregar uns san

  agregarScan(ScanModel scan) async {
    DBProvider.db.nuevaScanc(scan);
    await obtenerScans();
  }

  obtenerScans() async {
    _scansConstroller.sink.add(await DBProvider.db.getTodosScans());
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}
