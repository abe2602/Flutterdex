import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { info, techniques, more }

Map<TabItem, String> tabName = {
  TabItem.info: 'Information',
  TabItem.techniques: 'Techniques',
  TabItem.more: 'More'
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab}); //construtor
  final ValueChanged<TabItem> onSelectTab; //avisa qual tab foi selecionada
  final TabItem currentTab;
  final int currentIndex = 0;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        items: [
          _buildItem(icon: Icon(Icons.info), tabItem: TabItem.info),
          _buildItem(
              icon: Icon(Icons.gavel), tabItem: TabItem.techniques),
          _buildItem(icon: Icon(Icons.more_horiz), tabItem: TabItem.more),
        ],
        onTap: (index) {
          onSelectTab(
            TabItem.values[index],
          );
        },
        currentIndex: _getBottomNavigationItem(currentTab),
        showUnselectedLabels: false,
      );

  int _getBottomNavigationItem(TabItem tab) {
    var currentIndex = 0;

    switch (tab) {
      case TabItem.info:
        currentIndex = 0;
        break;

      case TabItem.techniques:
        currentIndex = 1;
        break;

      case TabItem.more:
        currentIndex = 2;
        break;
    }

    return currentIndex;
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem, Icon icon}) =>
      BottomNavigationBarItem(
        icon: icon,
        title: Text(
          tabName[tabItem],
          style: TextStyle(
            color: currentTab == tabItem ? Colors.blue : Colors.grey,
          ),
        ),
      );
}
