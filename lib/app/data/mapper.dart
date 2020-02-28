import 'package:state_navigation/domain/model/pokemon.dart';

import 'model/pokemon_rm.dart';

extension PokemonRMToDM on PokemonRM {
  Pokemon toDM() => Pokemon(name, detailUrl);
}
