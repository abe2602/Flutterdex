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

  final _pokemonListPublishSubject = BehaviorSubject<List<PokemonVM>>();

  Stream<List<PokemonVM>> get pokemonListStream =>
      _pokemonListPublishSubject.stream;
  final BuildContext _context;

  ScrollController scrollController = ScrollController();

  List<PokemonVM> paginatedPokemonList = [];

  PokemonVM toVM(Pokemon pokemon) => PokemonVM(pokemon.name, pokemon.detailUrl);

  int _page = 0;

  @override
  Future<void> getData({List params}) async {
    final paramsUc = GetPokemonListUcParams()..page = _page;
    return Provider.of<ApplicationDI>(_context)
        .getPokemonListUC()
        .call(paramsUc)
        .then((pokemonList) {
      paginatedPokemonList.addAll(List<PokemonVM>.from(pokemonList?.map(toVM)));
      _pokemonListPublishSubject.sink.add(paginatedPokemonList);
      _page += 10;
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
