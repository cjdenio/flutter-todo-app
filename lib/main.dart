import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'NewItemPage.dart';
import 'CustomBottomNav.dart';

import 'pages/SettingsPage.dart';
import 'pages/SyncPage.dart';

import 'models/ItemModel.dart';

ItemModel itemModel = ItemModel();

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext ctx) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.indigo,
            accentColor: Colors.indigoAccent,
            fontFamily: "Montserrat"),
        title: "To-do App",
        home: InitialPage());
  }
}

class InitialPage extends StatefulWidget {
  InitialPageState createState() => InitialPageState();
}

class InitialPageState extends State<InitialPage> {
  int pageIndex = 0;
  List<Widget> pages = [Home(), SyncPage(), SettingsPage()];

  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text("To-do App"),
        ),
        body: Center(child: pages[pageIndex]),
        floatingActionButton: (pageIndex == 0)
            ? FloatingActionButton(
                onPressed: () {
                  NewItemPage.show((String text) {
                    itemModel.add(Item(text, 1));
                  }, ctx);
                },
                child: Icon(Icons.add))
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // bottomNavigationBar: CustomBottomNav(
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.check),
        //       title: Text("Items"),
        //     ),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.cloud_upload), title: Text("Sync")),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.settings), title: Text("Settings"))
        //   ],
        //   onPressed: (index) {
        //     setState(() {
        //       pageIndex = index;
        //     });
        //   },
        //   selectedIndex: pageIndex,
        // )
        );
  }
}

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var itemsToUse = itemModel.items;
  void initState() {
    itemModel.addListener(changeHandler);
  }

  void dispose() {
    itemModel.removeListener(changeHandler);
    super.dispose();
  }

  void changeHandler() {
    setState(() {
      itemsToUse = itemModel.items;
    });
  }

  Widget build(BuildContext ctx) {
    if (itemsToUse.length == 0) {
      return Center(child: Text("No items, yet..."));
    }
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.separated(
            itemBuilder: (BuildContext ctx, int index) {
              Item item = itemsToUse[index];

              return ListTile(
                leading: Icon(item.finished
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                title: Text(
                  item.name,
                  style: TextStyle(
                      decoration: item.finished
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                onTap: () {
                  itemModel.setFinished(index, !itemsToUse[index].finished);
                },
                trailing: item.finished
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                              context: ctx,
                              builder: (BuildContext ctx2) {
                                return AlertDialog(
                                  title: Text("Are you sure?"),
                                  content: Text(
                                      "Are you sure you want to delete this item?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(ctx2).pop();
                                      },
                                    ),
                                    RaisedButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        itemModel.remove(index);
                                        Navigator.of(ctx2).pop();
                                        Scaffold.of(ctx).showSnackBar(SnackBar(content: Text("Item successfully deleted.")));
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      )
                    : null,
              );
            },
            separatorBuilder: (BuildContext ctx, int index) {
              return Divider();
            },
            itemCount: itemsToUse.length));
  }
}
