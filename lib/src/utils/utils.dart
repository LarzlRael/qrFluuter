import 'package:qrapp/src/providers/db_providers.dart';

import 'package:url_launcher/url_launcher.dart';

abrirScan(ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await launch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'No se pudo abrir el ${scan.valor}';
    }
  }
}
