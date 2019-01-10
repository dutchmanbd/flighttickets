import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  var bottomBarItems;
  final bottomNavigationBarItemStyle =
      TextStyle(fontStyle: FontStyle.normal, color: Colors.black);

  CustomAppBar() {
    bottomBarItems = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          title: Text(
            "Explore",
            style: bottomNavigationBarItemStyle,
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.black),
          title: Text(
            "WatchList",
            style: bottomNavigationBarItemStyle,
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.local_offer, color: Colors.black),
          title: Text(
            "Deals",
            style: bottomNavigationBarItemStyle,
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.black),
          title: Text(
            "Notifications",
            style: bottomNavigationBarItemStyle,
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: BottomNavigationBar(
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
