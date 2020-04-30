import 'package:flutter/widgets.dart';

class ItemModel extends ChangeNotifier {
  List<Item> items = [];

  add(Item item) {
    items.add(item);
    notifyListeners();
  }

  remove(int id) {
    items.removeAt(id);
    notifyListeners();
  }

  setFinished(int index, bool isFinished) {
    items[index].setFinished(isFinished);
    notifyListeners();
  }
}

class Item {
  String name;
  num id;
  bool finished = false;

  Item(this.name, this.id);

  String toString() {
    return this.name;
  }

  void setFinished(bool isFinished) {
    this.finished = isFinished;
  }
}
