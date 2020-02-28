class PokemonRM {
  PokemonRM(this.name, this.detailUrl);

  factory PokemonRM.fromJson(Map<String, dynamic> parsedJson) => PokemonRM(
        parsedJson['name'],
        parsedJson['url'],
      );

  String name, detailUrl;
}
