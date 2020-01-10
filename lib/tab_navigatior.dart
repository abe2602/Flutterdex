import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';
import 'movieList.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

//Associa o nome com a tab (recebe como parâmetro a key do navegador e uma tabItem)
class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  //Retorna os widgets possíveis na navegação
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context){
        if(tabItem == TabItem.movies){
          return MoviesList();
        }else{
          return MoviesList();
        }
      }
    };
  }

  //Retorna um novo widget com o próprio navegador
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
