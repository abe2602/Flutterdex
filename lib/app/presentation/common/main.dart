import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/data/cache/movieCM.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/common/tab_navigatior.dart';

import '../../../app/presentation/common/bottom_navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(MovieCMAdapter());
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider( //Possibilita a DI COM contexto
      create: (BuildContext context) => ApplicationDI(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  TabItem _currentTab = TabItem.movies;

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.movies: GlobalKey<NavigatorState>(),
    TabItem.series: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem){
    setState(() => _currentTab = tabItem);
  }

  //Serve para esconder as tabs que não são as atuais
  Widget _buildOffStageNavigator(TabItem tabItem){
    return Offstage(
      offstage: _currentTab != tabItem, //se for false, adiciona o widget na árvore
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async {
        return !await _navigatorKeys[_currentTab].currentState.maybePop();
      },

      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              _buildOffStageNavigator(TabItem.movies),
              _buildOffStageNavigator(TabItem.series),
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
}
