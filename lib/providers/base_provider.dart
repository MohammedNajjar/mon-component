import 'package:flutter/foundation.dart';

class BaseProvider<T> extends ChangeNotifier {
  List<T> _items = [];

  List<T> get items => _items;

  void addItem(T item) {
    _items.add(item);
    notifyListeners();
  }

  void addItems(List<T> newItems) {
    _items.addAll(newItems);
    notifyListeners();
  }

  void setItems(List<T> newItems) {
    clear(notify: false);
    _items.addAll(newItems);
    notifyListeners();
  }

  void updateItem(int index, T newItem) {
    _items[index] = newItem;
    notifyListeners();
  }

  void updateObject(T oldItem, T newItem) {
    final index = _items.indexOf(oldItem);
    if (index == -1) return;
    _items[index] = newItem;
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void deleteObject(T object) {
    _items.remove(object);
    notifyListeners();
  }

  void deleteAll({bool notify = true}) {
    _items.clear();
    if (notify) notifyListeners();
  }

  void clear({bool notify = true}) {
    deleteAll(notify: notify);
  }
}


// class BaseProvider<T> extends ChangeNotifier {
//   List<T> _items = [];
//
//   List<T> get items => _items;
//
//   void addItem(T item, {List<T>? list}) {
//     (list ?? _items).add(item);
//     notifyListeners();
//   }
//
//   void addItems(List<T> newItems, {List<T>? list}) {
//     (list ?? _items).addAll(newItems);
//     notifyListeners();
//   }
//
//   void setItems(List<T> newItems, {List<T>? list}) {
//     clear(notify: false);
//     (list ?? _items).addAll(newItems);
//     notifyListeners();
//   }
//
//   void updateItem(int index, T newItem, {List<T>? list}) {
//     (list ?? _items)[index] = newItem;
//     notifyListeners();
//   }
//
//   void updateObject(T oldItem, T newItem, {List<T>? list}) {
//     final index = (list ?? _items).indexOf(oldItem);
//     if (index == -1) return;
//     (list ?? _items)[index] = newItem;
//     notifyListeners();
//   }
//
//   void deleteItem(int index, {List<T>? list}) {
//     (list ?? _items).removeAt(index);
//     notifyListeners();
//   }
//
//   void deleteObject(T object, {List<T>? list}) {
//     (list ?? _items).remove(object);
//     notifyListeners();
//   }
//
//   void deleteAll({bool notify = true, List<T>? list}) {
//     (list ?? _items).clear();
//     if (notify) notifyListeners();
//   }
//
//   void clear({bool notify = true, List<T>? list}) {
//     deleteAll(notify: notify);
//   }
// }
