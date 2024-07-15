import 'package:flutter/material.dart';
import 'package:wefgis_app/screen/main_home.dart';

import 'package:wefgis_app/screen/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Wefgis App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/map',
      routes: {
        '/': (context) => HistoriListPage(),
        '/map': (context) => const MapScreen(),
        // '/mapAdd' :(context) => const MapFormScreen()
      },
    );
  }
}
