import 'package:cart_hive/home/home_page.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'model/product.dart';

void main() async {
  // asegurarnos de inicialiazar antes de crear app
  WidgetsFlutterBinding.ensureInitialized();
  // acceder al local storage
  final _localStorage = await getExternalStorageDirectory();
  // inicializar hive pasandole path al local storage
  Hive
    ..init(_localStorage.path)
    ..registerAdapter(CarritoAdapter());
  await Hive.openBox("Carrito");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
