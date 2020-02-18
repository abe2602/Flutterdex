import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/data/model/movie_cm.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/common/tab_navigatior.dart';

import '../../../app/presentation/common/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getApplicationDocumentsDirectory().then((directory){
    Hive.init(directory.path);
    final movieCMAdapter = MovieCMAdapter();
    Hive.registerAdapter(movieCMAdapter);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => ApplicationDI(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TabItem _currentTab = TabItem.movies;

  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.movies: GlobalKey<NavigatorState>(),
    TabItem.favorites: GlobalKey<NavigatorState>(),
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
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                _buildOffStageNavigator(TabItem.movies),
                _buildOffStageNavigator(TabItem.favorites),
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
