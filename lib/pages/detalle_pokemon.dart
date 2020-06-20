import 'package:flutter/material.dart';
import 'package:pokedex/models/modelo_pokemon.dart';
import 'package:pokedex/providers/provider_pokemon.dart';

class DetallePokemon extends StatelessWidget {
  final pokemonProvider = new ProviderPokemon();
  
  @override
  Widget build(BuildContext context) {
    final Pokemon dataPokemon = ModalRoute.of(context).settings.arguments;
    return Scaffold(
     body: CustomScrollView(
       slivers: <Widget>[
         _crearAppBar(dataPokemon.name, dataPokemon.sprites['front_default']),
         SliverList(
           delegate: SliverChildListDelegate([
              SizedBox(height: 4.0,),
              _sprites(dataPokemon.sprites),
              SizedBox(height: 10.0,),
              _types(dataPokemon.types),
              SizedBox(height: 10.0,),
              //['ability']['name']
              _scrollCardRight('Abilities', 'ability',  'name', dataPokemon.abilities),
              SizedBox(height: 10.0,),
              //['move']['name']
              _scrollCardRight('Moves', 'move', 'name', dataPokemon.moves),
              SizedBox(height: 10.0,),
              _cardGamesIndices(dataPokemon.gameIndices),
              SizedBox(height: 10.0,),
              _cardStats(dataPokemon.stats),
              SizedBox(height: 10.0,),
               
             ]
           ),
         )
       ],
     ),
    );
  }


  Widget _crearAppBar(String nombrePokemon, String spriteRoute){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent,
      expandedHeight: 250.0,
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
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(spriteRoute),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _sprites(Map<dynamic, dynamic> spritesParams){

    String backFemale = spritesParams['back_female']!=null?spritesParams['back_female']:'',
          frontFemale = spritesParams['front_female']!=null?spritesParams['front_female']:'',
          backShinyFemale = spritesParams['back_shiny_female']!=null?spritesParams['back_shiny_female']:'',
          frontShinyFemale = spritesParams['front_shiny_female']!=null?spritesParams['front_shiny_female']:'';

    String backMale = spritesParams['back_default']!=null?spritesParams['back_default']:'',
          frontMale = spritesParams['front_default']!=null?spritesParams['front_default']:'',
          backShinyMale = spritesParams['back_shiny']!=null?spritesParams['back_shiny']:'',
          frontShinyMale = spritesParams['front_shiny']!=null?spritesParams['front_shiny']:'';
    return Container(
      child: Column(
        children: <Widget>[
          //Pokemon hembra
          SizedBox(height: 10.0),
          SizedBox(
            height: 35.0,
            child: Text(
              'Females',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0
              ),
            ),
          ),
          SizedBox(height: 20.0),
          _spritesShapes(backFemale, frontFemale, backShinyFemale, frontShinyFemale),
          SizedBox(height: 20.0),
          SizedBox(
            height: 35.0,
            child: Text(
              'Males',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0
              ),
            ),
          ),
          _spritesShapes(backMale, frontMale, backShinyMale, frontShinyMale),
        ],
      ),
    );
  }

  Widget _spritesShapes(String backPokemon, String frontPokemon, String backShinyPokemon, String frontShinyPokemon){
    return Row(
            children: <Widget>[
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(frontPokemon),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(backPokemon),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              //Shinys
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(frontShinyPokemon),
                  height: 100.0,
                  width: 10.0,
                )
              ),
              Expanded(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(backShinyPokemon),
                  height: 100.0,
                  width: 10.0,
                )
              ),
            ],
          );
  }

  Widget _types(List typesPokemon){
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Types: ${typesPokemon.length}',
            style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0
            ),
          ),
          SizedBox(height: 15.0,),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: typesPokemon.map((typePokemon){
              return Container(
                margin: EdgeInsets.only(right: 25.0),
                child: Text(
                  typePokemon['type']['name'].toString().toUpperCase(),
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20.0
                  ),
                  
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _abilities(List<dynamic> pokemonAbilities){
    return Container(
      child: Column(
        children: pokemonAbilities.map((pokemonAbilitie){
          return ListTile(
            title: Text('Abilitie'),
            subtitle: Text(pokemonAbilitie['ability']['name']),
          );
        }).toList(),
      ),
    );
  }

  Widget _movesPokemon(List<dynamic> movesPokemons){
    // int lenMoves = (movesParam.length<=4?movesParam.length:4);
    //movesPokemons[index]['move']['name']
    return Container(
      child: Column(
        children: movesPokemons.map((pokemonMove){
          return ListTile(
            title: Text('Move'),
            subtitle: Text(pokemonMove['move']['name']),
          );
        }).toList(),
      ),
    );
  }

  Widget _scrollCardRight(String property, String keyOnePokemonProperty,String keyTwoPokemonProperty,List<dynamic> pokemonProperty){
    return SizedBox(
      height: 120.0,
      width: 10.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Text(
              '$property : ${pokemonProperty.length}',
              style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: pokemonProperty.length,
              itemBuilder: (BuildContext context, int index){
                return _boxStyleProperty(pokemonProperty[index][keyOnePokemonProperty][keyTwoPokemonProperty]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxStyleProperty(String property){
    return Container(
      height: 100.0,
      width: 90.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(1.0, 5.0)
          )
        ]
      ),
      padding: EdgeInsets.only(top: 25.0, right: 20.0, bottom: 25.0, left: 20.0),
      child: Text(
        property.toUpperCase(),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _cardGamesIndices(List<dynamic> gamesIndices){
     return SizedBox(
      height: 165.0,
      width: 10.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Text(
              'Game Indices: ${gamesIndices.length}',
              style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: gamesIndices.length,
              itemBuilder: (BuildContext context, int index){
                return _styleCardGamesIndices(gamesIndices[index]['version']['name'], gamesIndices[index]['game_index']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _styleCardGamesIndices(String nameGame, int index){
     return Container(
      height: 100.0,
      width: 90.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(1.0, 5.0)
          )
        ]
      ),
      padding: EdgeInsets.only(top: 25.0, right: 20.0, bottom: 25.0, left: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Name: ${nameGame.toUpperCase()}',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            'Game index: $index',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardStats(List<dynamic> pokemonStats){
    return SizedBox(
      height: 210.0,
      width: 10.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Text(
              'Game Indices: ${pokemonStats.length}',
              style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: pokemonStats.length,
              itemBuilder: (BuildContext context, int index){
                return _styleCardStats(pokemonStats[index]['base_stat'], pokemonStats[index]['effort'], pokemonStats[index]['stat']['name']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _styleCardStats(int baseStat, int effort, String name){
    return Container(
      height: 150.0,
      width: 90.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(1.0, 5.0)
          )
        ]
      ),
      padding: EdgeInsets.only(top: 25.0, right: 20.0, bottom: 25.0, left: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Name: ${name.toUpperCase()}',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            'Base stat: $baseStat',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            'Effort: $effort',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }


}