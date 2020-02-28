import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_navigation/app/presentation/pokemon_detail/bottom_navigation.dart';
import 'package:state_navigation/app/presentation/pokemon_detail/tab_navigatior.dart';

class PokemonDetailView extends StatefulWidget {
  @override
  _PokemonDetailViewState createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  TabItem _currentTab = TabItem.info;

  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.info: GlobalKey<NavigatorState>(),
    TabItem.techniques: GlobalKey<NavigatorState>(),
    TabItem.more: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  //Serve para esconder as tabs que não são as atuais
  Widget _buildOffStageNavigator(TabItem tabItem) => Offstage(
    offstage: _currentTab != tabItem,
    //se for false, adiciona o widget na árvore
    child: TabNavigator(
      navigatorKey: _navigatorKeys[tabItem],
      tabItem: tabItem,
    ),
  );

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async =>
    !await _navigatorKeys[_currentTab].currentState.maybePop(),
    child: Scaffold(
      appBar: AppBar(title: Text("Pokemon Details"),),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildOffStageNavigator(TabItem.info),
            _buildOffStageNavigator(TabItem.techniques),
            _buildOffStageNavigator(TabItem.more),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        onSelectTab: _selectTab,
        currentTab: _currentTab,
      ),
    ),
  );
}
