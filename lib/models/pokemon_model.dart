class PokemonModel {
  int id;
  String name;
  String imageUrl;
  int weight;
  int height;
  String type1;
  String type2;
  int health;
  int attack;
  int defense;
  int speed;

  PokemonModel({
    this.id,
    this.name,
    this.imageUrl,
    this.weight,
    this.height,
    this.type1,
    this.type2,
    this.health,
    this.attack,
    this.defense,
    this.speed,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final id = map['id'];
    final typeList = map['types'] as List;
    final statList = map['stats'] as List;
    return PokemonModel(
      id: id,
      name: map['name'],
      weight: map['weight'],
      height: map['height'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      type1: typeList[0]['type']['name'],
      type2: typeList.length == 2 ? typeList[1]['type']['name'] : null,
      health: statList[0]['base_stat'],
      attack: statList[1]['base_stat'],
      defense: statList[2]['base_stat'],
      speed: statList[5]['base_stat'],
    );
  }
}
