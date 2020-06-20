import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:pokedex/models/modelo_pokemon.dart';

class ProviderPokemon{
  final _url = '';
  

  Future<Pokemon> irPorPokemon(String nombrePokemon) async {
    final respuesta = await http.get('https://pokeapi.co/api/v2/pokemon/$nombrePokemon');

    if(respuesta.statusCode == 404 || respuesta.statusCode == 500) return null;

    final decodedJson = json.decode(respuesta.body);

    final pokemon = new Pokemon.fromJsonMap(decodedJson);
    


    return pokemon;
  }

}