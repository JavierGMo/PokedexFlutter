import 'package:flutter/material.dart';

class BuscadorPokemon extends StatefulWidget {
  @override
  _BuscadorPokemonState createState() => _BuscadorPokemonState();
}

class _BuscadorPokemonState extends State<BuscadorPokemon> {

  String nombrePokemon = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex!!!'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
      child: Column(
        children: <Widget>[
            SizedBox(height: 30.0,),
            _inputText(),
          ],
        ),        
      ),
    );
  }

  Widget _inputText(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre del pokemon',
        labelText: 'Pokemon',
        icon: Icon(Icons.account_circle)
      ),
      onSubmitted: (valor){
        setState(() {
          nombrePokemon = valor;
          print(nombrePokemon);
        });
      },
    );
  }
}