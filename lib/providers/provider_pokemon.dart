import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:pokedex/models/modelo_pokemon.dart';

class ProviderPokemon{
  final _url = '';
  

  Future<Pokemon> irPorPokemon(String nombrePokemon) async {
    print('**************$nombrePokemon*************');
    final respuesta = await http.get('https://pokeapi.co/api/v2/pokemon/$nombrePokemon');

    final decodedJson = json.decode(respuesta.body);

    final pokemon = new Pokemon.fromJsonMap(decodedJson);

    print(decodedJson['sprites']);
    


    return pokemon;
  }

}