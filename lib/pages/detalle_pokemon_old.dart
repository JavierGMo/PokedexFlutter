import 'package:flutter/material.dart';
import 'package:pokedex/models/modelo_pokemon.dart';
import 'package:pokedex/providers/provider_pokemon.dart';

class DetallePokemon extends StatelessWidget {
  final pokemonProvider = new ProviderPokemon();
  
  @override
  Widget build(BuildContext context) {
    String nombrePokemon = ModalRoute.of(context).settings.arguments;
    return Scaffold(
     body: CustomScrollView(
       slivers: <Widget>[
         _crearAppBar(nombrePokemon),
         SliverList(
           delegate: SliverChildListDelegate(
             [
               SizedBox(height: 5.0,),
               SizedBox(
                 width: 20.0,
                 child: _infoPokemon(nombrePokemon)
                ),
             ]
           ),
         )
       ],
     ),
    );
  }


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
            width: 10.0,
              child: Column(
                children: <Widget>[
                    SizedBox(
                      child: _spites(snapshot.data.sprites),
                    ),
                    SizedBox(child: _habilidades(snapshot.data)),
                    SizedBox(child: _movesPokemon(snapshot.data.moves)),
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


  Widget _hablidadesBack(Pokemon pokemon){
    List<dynamic> habilidadesPokemon = pokemon.abilities;
    return ListView(
      children: habilidadesPokemon.map((habilidad){
        return ListTile(
          title: Text("habilidad['ability']['name']"),
        );
      }).toList(),
    );
  }

  Widget _spites(Map<dynamic, dynamic> spritesParams){
    String backFemale = spritesParams['back_female']!=null?spritesParams['back_female']:'',
          frontFemale = spritesParams['front_female']!=null?spritesParams['front_female']:'',
          backShinyFemale = spritesParams['back_shiny_female']!=null?spritesParams['back_shiny_female']:'',
          frontShinyFemales = spritesParams['front_shiny_female']!=null?spritesParams['front_shiny_female']:'';
    return Container(
      child: Column(
        children: <Widget>[
          //Pokemon hembra
          SizedBox(height: 10.0),
          SizedBox(
            height: 35.0,
            child: Text('Females'),
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(backFemale),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(frontFemale),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              //Shinys
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(backShinyFemale),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(frontShinyFemales),
                  height: 100.0,
                  width: 10.0,
                )
              ),
            ],
          ),
          SizedBox(height: 20.0),
          SizedBox(
            height: 35.0,
            child: Text('Males'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(spritesParams['front_default']),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(spritesParams['back_default']),
                  height: 100.0,
                  width: 10.0,
                  fit: BoxFit.contain,
                )
              ),
              
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(spritesParams['front_shiny']),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(spritesParams['back_shiny']),
                  height: 100.0,
                  width: 10.0,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _habilidades(Pokemon pokemon){
    List<dynamic> habilidadesPokemon = pokemon.abilities;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: habilidadesPokemon.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text('Abilitie:'),
          subtitle: Text(habilidadesPokemon[index]['ability']['name']),
        );
      },
    );
  }

  Widget _movesPokemon(List movesParam){
    // int lenMoves = (movesParam.length<=4?movesParam.length:4);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text('Move:'),
          subtitle: Text(movesParam[index]['move']['name']),
        );
      },
    );
  }

}