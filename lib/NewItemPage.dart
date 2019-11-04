import 'package:flutter/material.dart';
import 'items.dart';

class NewItemPage extends StatelessWidget{
  Widget build(BuildContext ctx){
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
                    items.add({
                      "name": controller.text,
                      "finished": false
                    });
                    
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