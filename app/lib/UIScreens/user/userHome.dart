import 'package:flutter/material.dart';
import 'package:saveat/UIScreens/user/bottomAppBar/fab_bottom_app_bar.dart';
import 'package:saveat/UIScreens/user/tabs/categoryTab.dart';
import 'package:saveat/UIScreens/user/tabs/favouriteTab.dart';
import 'package:saveat/UIScreens/user/tabs/profileTab.dart';
import 'package:saveat/UIScreens/user/tabs/userHomeTab.dart';
import 'package:saveat/routes/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
bool checkValue = false;
String name, email, type, userID;

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _lastSelected = 0;
  var pages = [
    new UserHomeTab(userID),
    new MyCategoryTab(userID),
    new FavouriteTab(),
    new ProfileTab()
  ];
  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  //on back press button dialogue
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCredential();
  }

  _getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          setState(() {
            email = sharedPreferences.getString("Email");
            name = sharedPreferences.getString("Name");
            type = sharedPreferences.getString("Type");
            userID = sharedPreferences.getString("id");
          });
        } else {
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: pages[_lastSelected],
          bottomNavigationBar: FABBottomAppBar(
            color: Colors.grey,
            backgroundColor: Colors.white,
            selectedColor: Colors.green,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              FABBottomAppBarItem(iconData: Icons.home),
              FABBottomAppBarItem(iconData: Icons.category),
              FABBottomAppBarItem(iconData: Icons.favorite),
              FABBottomAppBarItem(iconData: Icons.person),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              MyRoute.goToCart(context, userID);
            },
            child: Icon(Icons.shopping_cart),
          ),
        ));
  }
}
