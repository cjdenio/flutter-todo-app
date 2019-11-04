import 'package:flutter/material.dart';
import 'items.dart';
import 'dart:convert';

class ListItem extends StatefulWidget{
  String text;
  bool finished;
  Function onRemoved;
  int index;

  ListItem({this.text, this.finished, this.onRemoved, this.index});
  ListItemState createState() => ListItemState();
}

class ListItemState extends State<ListItem>{
  Widget build(BuildContext ctx){
    return ListTile(
      title: Text(widget.text, style: TextStyle(
        decoration: widget.finished ? TextDecoration.lineThrough : null
      )),
      leading: Icon(widget.finished ? Icons.check_box : Icons.check_box_outline_blank),
      trailing: widget.finished ? IconButton(
        icon: Icon(Icons.delete),
        onPressed: (){
            widget.onRemoved();
            //print(this.text);
        },
      ) : null,
      onTap: (){
        setState(() {
          if(!widget.finished){
            widget.finished = true;
            items[widget.index]['finished'] = true;
          }
          else{
            widget.finished = false;
            items[widget.index]['finished'] = false;
          }
        });
      },
    );
  }
}