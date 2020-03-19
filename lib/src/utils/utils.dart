import 'package:flutter/cupertino.dart';
import 'package:qrapp/src/providers/db_providers.dart';

import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context ,ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await launch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'No se pudo abrir el ${scan.valor}';
    }
  }else{
    //metodo para ir a la pagina con los argumetnos
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }
}
