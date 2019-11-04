import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget{
  List<BottomNavigationBarItem> items;
  CustomBottomNav({this.items});
  int selectedIndex = 0;

  CustomBottomNavState createState() => CustomBottomNavState();
}

class CustomBottomNavState extends State<CustomBottomNav>{
  Widget build(BuildContext ctx){
    return BottomNavigationBar(
      items: widget.items,
      currentIndex: widget.selectedIndex,
      onTap: (index){
        setState((){
          widget.selectedIndex = index;
        });
      },
    );
  }
}