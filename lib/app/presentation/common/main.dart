import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/pokemon_list/pokemon_list_view.dart';
import 'package:state_navigation/app/presentation/pokemon_detail/tab_navigatior.dart';

import '../pokemon_detail/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getApplicationDocumentsDirectory().then((directory) {
    runApp(Provider(create: (context) => ApplicationDI(), child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PokemonListView.create(context),
      );
}
