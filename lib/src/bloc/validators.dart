

import 'dart:async';

import 'package:qrapp/src/providers/db_providers.dart';

class Validators{

  //recibimos infomacion del stream transformer
  // el primer argumente va a aceptar solo scans model y el otro es lo que va a salir
  final validarGeo = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans,sink){
        final geoScans = scans.where((s)=>s.tipo=='geo').toList();
        sink.add(geoScans);
    }
  );
  final validarHttp = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans,sink){
        final geoScans = scans.where((s)=>s.tipo=='http').toList();
        sink.add(geoScans);
    }
  );

}