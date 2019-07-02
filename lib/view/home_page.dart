import 'package:flutter/material.dart';
import 'news_page.dart';
import 'saved_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  Map<int, _HomePageItem> _content = {
    0: _HomePageItem(
        icon: Icon(Icons.public),
        name: "News",
        page: NewsPage(key: Key("news"))),
    1: _HomePageItem(
        icon: Icon(Icons.book),
        name: "Saved",
        page: NewsPage(key: Key("saved"), showOnlySaved: true)),
    2: _HomePageItem(
        icon: Icon(Icons.settings), name: "Settings", page: SettingsPage())
  };

  List<BottomNavigationBarItem> _getNavigationItems() {
    List<BottomNavigationBarItem> result = List();
    _content.values.forEach((item) {
      result.add(item.navigationItem);
    });
    return result;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global News app"),
      ),
      //backgroundColor: Colors.white,
      body: _content[_currentPageIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: _getNavigationItems(),
        onTap: onTabTapped,
        //unselectedItemColor: Colors.grey,
        //selectedItemColor: Colors.black,
      ),
    );
  }
}

class _HomePageItem {
  final Icon icon;
  final String name;
  final Widget page;

  _HomePageItem(
      {@required this.icon, @required this.name, @required this.page});

  BottomNavigationBarItem get navigationItem {
    return BottomNavigationBarItem(icon: icon, title: Text(name));
  }
}
