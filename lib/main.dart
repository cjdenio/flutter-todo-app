import 'package:flutter/material.dart';
import 'NewItemPage.dart';
import 'ListItem.dart';
import 'CustomBottomNav.dart';

import 'items.dart';

void main(){
  runApp(App());
}
class App extends StatelessWidget{
  Widget build(BuildContext ctx){
    return MaterialApp(
      title: "To-do App",
      home: InitialPage()
    );
  }
}

class InitialPage extends StatelessWidget{
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: AppBar(
        title: Text("To-do App"),
      ),
      body: Center(
        child: Home()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(ctx).push(MaterialPageRoute(
            builder: (BuildContext ctx){
              return NewItemPage();
            }
          ));
        },
        child: Icon(Icons.add)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomNav(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text("Items"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload),
            title: Text("Sync")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings")
          )
        ]
      )
    );
  }
}

class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{
  Widget build(BuildContext ctx){
    var itemsToUse = items;
    if(itemsToUse.length == 0){
      return Center(
        child: Text("No items, yet...")
      );
    }
    return ListView.separated(
      itemBuilder: (BuildContext ctx, int index){
        return ListItem(
          text: itemsToUse[index]['name'],
          finished: itemsToUse[index]['finished'],
          index: index,
          onRemoved: (){
            setState((){
              items.removeAt(index);
            });
          },
        );
      },
      separatorBuilder: (BuildContext ctx, int index){
        return Divider();
      },
      itemCount: itemsToUse.length
    );
  }
}