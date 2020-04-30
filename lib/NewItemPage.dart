import 'package:flutter/material.dart';

class NewItemPage{
  static void show(Function callback, BuildContext ctx){
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (ctx2){
        return build(ctx2, callback);
      }
    ));
  }

  static Widget build(BuildContext ctx, Function callback){
    TextEditingController controller = TextEditingController();

    TextField textField = TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Item Title"
      ),
      controller: controller,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("New Item")
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: textField,
              width: 300
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: (){
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Cancel")
                ),
                RaisedButton(
                  onPressed: (){
                    callback(controller.text);
                    
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Create"),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ),
    );
  }
}