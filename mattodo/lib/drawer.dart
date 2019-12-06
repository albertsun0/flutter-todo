import 'package:flutter/material.dart';
import 'list.dart';
import 'repeating.dart';
import 'settings.dart';
import 'themes.dart';

class Home extends StatefulWidget {
  final ThemeBloc themeBloc;

  const Home({Key key, this.themeBloc}) : super(key: key);
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int _page = 0;

  List drawerItems = [
    {
      "icon": Icons.list,
      "name": "To Do List",
    },
    {
      "icon": Icons.calendar_today,
      "name": "Repeating",
    },
    {
      "icon": Icons.settings,
      "name": "Options",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("To Do"),
        elevation: 0.5,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                Map item = drawerItems[index];
                return ListTile(
                  leading: Icon(
                    item['icon'],
                    color: _page == index
                        ?Theme.of(context).accentColor
                        :Theme.of(context).textTheme.title.color,
                  ),
                  title: Text(
                    item['name'],
                    style: TextStyle(
                      color: _page == index
                          ?Theme.of(context).accentColor
                          :Theme.of(context).textTheme.title.color,
                    ),
                  ),
                  onTap: (){
                    _pageController.jumpToPage(index);
                    Navigator.pop(context);
                  },
                );
              },

            ),
          ],
        ),
      ),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          TodoList(storage: CounterStorage()),   //////////////////////////////////////////
          Repeat(),
          Settings(themeBloc: widget.themeBloc,),
        ],
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}