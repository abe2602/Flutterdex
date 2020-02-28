import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/base_bloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/pokemon_list/model.dart';
import 'package:state_navigation/domain/model/pokemon.dart';
import 'package:state_navigation/domain/usecase/get_pokemon_list_uc.dart';

class PokemonListBloc extends BlocBase implements BaseBloc {
  PokemonListBloc(this._context);

  final _pokemonListPublishSubject = PublishSubject<List<PokemonVM>>();

  Stream<List<PokemonVM>> get pokemonListStream =>
      _pokemonListPublishSubject.stream;
  final BuildContext _context;

  List<PokemonVM> paginatedPokemonList = [];

  PokemonVM toVM(Pokemon pokemon) => PokemonVM(pokemon.name, pokemon.detailUrl);

  @override
  Future<void> getData({List params}) async {
    var paramsUc = GetPokemonListUcParams()..page = params[0];
    return Provider.of<ApplicationDI>(_context)
        .getPokemonListUC()
        .call(paramsUc)
        .then((pokemonList) {
      paginatedPokemonList.addAll(List<PokemonVM>.from(pokemonList?.map(toVM)));
      _pokemonListPublishSubject.sink.add(paginatedPokemonList);
    });
  }

  @override
  void loading() => _pokemonListPublishSubject.sink.add(null);

  @override
  void dispose() {
    _pokemonListPublishSubject.close();
    super.dispose();
  }
}
