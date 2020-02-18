import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { movies, favorites }

Map<TabItem, String> tabName = {
  TabItem.movies: 'Filmes',
  TabItem.favorites: 'Favoritos',
};

class BottomNavigation extends StatelessWidget {
  final ValueChanged<TabItem> onSelectTab; //avisa qual tab foi selecionada
  final TabItem currentTab;
  final int currentIndex = 0;

  BottomNavigation({this.currentTab, this.onSelectTab}); //construtor

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildItem(icon: Icon(Icons.movie_filter), tabItem: TabItem.movies),
        _buildItem(icon: Icon(Icons.movie_filter), tabItem: TabItem.favorites),
      ],
      onTap: (index) {
        onSelectTab(
          TabItem.values[index],
        );
      },
      currentIndex: _getBottomNavigationItem(currentTab),
    );
  }

  int _getBottomNavigationItem(TabItem tab) {
    int currentIndex = 0;

    switch (tab) {
      case TabItem.movies:
        currentIndex = 0;
        break;

      case TabItem.favorites:
        currentIndex = 1;
        break;
    }

    return currentIndex;
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem, Icon icon}) {
    return BottomNavigationBarItem(
      icon: icon,
      title: Text(
        tabName[tabItem],
        style: TextStyle(
          color: currentTab == tabItem ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
