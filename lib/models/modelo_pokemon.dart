class Pokemon {
  List<dynamic> abilities;
  int baseExperience;
  List<dynamic> forms;
  List<dynamic> gameIndices;
  int height;
  List<dynamic> heldItems;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<dynamic> moves;
  String name;
  int order;
  Map<dynamic, dynamic> species;
  Map<dynamic, dynamic> sprites;
  List<dynamic> stats;
  List<dynamic> types;
  int weight;

  Pokemon({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.gameIndices,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  Pokemon.fromJsonMap(Map<String, dynamic> json){
    abilities = json['abilities'];
    baseExperience = json['base_experience'];
    forms = json['forms'];
    gameIndices = json['game_indices'];
    height = json['height'];
    heldItems = json['held_items'];
    id = json['id'];
    isDefault = json['is_default'];
    locationAreaEncounters = json['location_area_encounters'];
    moves = json['moves'];
    name = json['name'];
    order = json['order'];
    species = json['species'];
    sprites = json['sprites'];
    stats = json['stats'];
    types = json['types'];
    weight = json['weight'];    

  }
}

