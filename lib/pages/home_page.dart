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
  Color colorRedCool = Color.fromRGBO(243, 33, 93, 1.0);

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex!!!'),
        backgroundColor: colorRedCool,
      ),
      backgroundColor: Color.fromRGBO(49, 49, 49, 1.0),
      body: Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0,),
          Center(child: _inputText(mediaSize),),
          SizedBox(height: 30.0,),
          _botonBuscar(context, mediaSize),
          SizedBox(height: 30.0,),
        ],
      ),        
      ),
    );
  }

  Widget _inputText(Size media){
    return Container(
      width: media.width - 50.0,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: colorRedCool,
          ),
          labelStyle: TextStyle(
            color: colorRedCool,
            decorationColor: colorRedCool,
          ),
          fillColor: colorRedCool,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0,color: colorRedCool),
          ),
          hintText: 'Pokemon name',
          labelText: 'Pokemon name',
        ),
        onSubmitted: (valor){
          setState(() {
            this.nombrePokemonInput = valor;
          });
        },
      ),
    );
  }
  
  Widget _botonBuscar(BuildContext context, Size media){
    return Container(
      width: media.width-50.0,
      child: RaisedButton(
        color: Color.fromRGBO(243, 163, 33, 1.0),
        padding: EdgeInsets.only(top: 15.0, right: 25.0, bottom: 15.0, left: 25.0 ),
        child: Text(
          'Search pokemon',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Raleway',
            color: Colors.white
          ),
        ),
        onPressed: ()async {
          if(nombrePokemonInput.trim() != ''){
            
            this.nombrePokemon = this.nombrePokemonInput.trim().toLowerCase();
            this.nombrePokemonInput = '';
            this.dataPokemon = await providerPokemon.irPorPokemon(nombrePokemon);
            if(this.dataPokemon != null){
              Navigator.pushNamed(context, 'detalle', arguments: this.dataPokemon);
            }else if(this.dataPokemon == null){
              _mostrarAlerta(context, '¡Wow! An error has occurred..', 'Write the name of the pokemon well or contact the administrator.');
            }
             
          }else{
            _mostrarAlerta(context, '¡Wow! Empty text.', 'Write the name of a pokemon.');
          }
          
        },
      ),
    );
  }

  void _mostrarAlerta(BuildContext context, String titulo, String mensaje){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(titulo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(mensaje),
              FlutterLogo(size: 150.0,),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }
  
}