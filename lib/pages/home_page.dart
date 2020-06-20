import 'package:flutter/material.dart';
import 'package:pokedex/models/modelo_pokemon.dart';
import 'package:pokedex/providers/provider_pokemon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String nombrePokemon = '';
  String nombrePokemonInput = '';
  ProviderPokemon providerPokemon = new ProviderPokemon();
  Pokemon dataPokemon;


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
          SizedBox(height: 30.0,),
          _botonBuscar(),
          SizedBox(height: 30.0,),
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
          this.nombrePokemonInput = valor;
          print(nombrePokemon);
        });
      },
    );
  }
  Widget _botonBuscar(){
    return RaisedButton(
      color: Colors.redAccent,
      padding: EdgeInsets.only(top: 15.0, right: 25.0, bottom: 15.0, left: 25.0 ),
      child: Text(
        'Buscar',
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Raleway',
        ),
      ),
      onPressed: ()async {
        if(nombrePokemonInput.trim() != ''){
          
          this.nombrePokemon = this.nombrePokemonInput..trim()..toLowerCase();
          this.nombrePokemonInput = '';
          this.dataPokemon = await providerPokemon.irPorPokemon(nombrePokemon);
          if(this.dataPokemon != null){
            Navigator.pushNamed(context, 'detalle', arguments: this.dataPokemon);
          }
           
        }
        
        
      },
    );
  }
  
  
}