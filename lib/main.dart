import 'package:flutter/material.dart';

import 'package:pokedex/pages/home_page.dart';
import 'package:pokedex/pages/detalle_pokemon.dart';
import 'package:pokedex/pages/pokemon_detalle.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',      
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => DetallePokemon()
      },
    );
  }
}

