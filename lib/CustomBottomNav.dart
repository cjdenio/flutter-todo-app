import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget{
  List<BottomNavigationBarItem> items;
  Function onPressed;
  int selectedIndex;

  CustomBottomNav({this.items, this.onPressed, this.selectedIndex});

  CustomBottomNavState createState() => CustomBottomNavState();
}

class CustomBottomNavState extends State<CustomBottomNav>{
  Widget build(BuildContext ctx){
    return BottomNavigationBar(
      items: widget.items,
      currentIndex: widget.selectedIndex,
      onTap: (index){
        widget.onPressed(index);
      },
    );
  }
}