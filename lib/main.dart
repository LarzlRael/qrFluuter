import 'package:flutter/material.dart';
import 'package:qrapp/src/pages/home_page.dart';

import 'src/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qr reader',
      initialRoute: 'home',
      routes: {
        'home':(BuildContext context)=>Home(),
        'mapa':(BuildContext context)=>MapaPage(),
      },
      //sirve para cambiar el thema principal de la aplicion
      theme: ThemeData(
        primaryColor: Colors.purple
      ) ,
    );
  }
}