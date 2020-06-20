import 'package:flutter/material.dart';
import 'package:pokedex/models/modelo_pokemon.dart';
import 'package:pokedex/providers/provider_pokemon.dart';
class PokemonDetalle extends StatefulWidget {
  PokemonDetalle({Key key}) : super(key: key);

  @override
  _PokemonDetalleState createState() => _PokemonDetalleState();
}

class _PokemonDetalleState extends State<PokemonDetalle> {
  @override
  final pokemonProvider = new ProviderPokemon();
  Widget build(BuildContext context) {
    final Pokemon dataPokemon = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
     body: CustomScrollView(
       slivers: <Widget>[
         _crearAppBar(dataPokemon.name),
         SliverList(
           delegate: SliverChildListDelegate(
             [
               SizedBox(height: 11.0,),
               //_infoPokemon(nombrePokemon),
             ]
           ),
         )
       ],
     ),
    );
  }

  //Metodos propios
   Widget _crearAppBar(String nombrePokemon){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          nombrePokemon.toUpperCase(),
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20.0
          ),
        ),
      ),
    );
  }

  Widget _infoPokemon(String nombrePokemonParam){


    return FutureBuilder(
      future: pokemonProvider.irPorPokemon(nombrePokemonParam),
      builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot){
       if(snapshot.hasData){
          return Container(
              child: Column(
                children: <Widget>[
                  _habilidades(snapshot.data),
                ],
              ),
          );
        }
        return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }

  Widget _habilidades(Pokemon pokemon){
    if(pokemon == null) return Container();
    List<dynamic> habilidadesPokemon = pokemon.abilities;
    return ListView.builder(
      itemCount: habilidadesPokemon.length,
      itemBuilder: (BuildContext context, int index){
        print('habilidades: =====> ${habilidadesPokemon[index]['ability']['name']}');
        return ListTile(
          title: Text(habilidadesPokemon[index]),
        );
      },
    );
  }



}