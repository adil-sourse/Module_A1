import 'package:flutter/cupertino.dart';

class BasketModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  final int cost = 24000;
  List<Map<String, dynamic>> get items => _items;

  int get totalPrice {
    return _items.fold(0, (sum, item) {
      final price = cost;
      final quantity = (item['quantity'] ?? 1) as int;
      return sum + (price * quantity);
    });
  }

  void addItem(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);

    if (index != -1) {
      _items[index]['quantity'] += 1;
    } else {
      _items.add({
        ...product,
        'quantity': 1,
        'id': DateTime.now().millisecondsSinceEpoch
      });
    }

    notifyListeners();
  }

  void removeItem(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['name'] == product['name']);

    if (index != -1) {
      if (_items[index]['quantity'] > 1) {
        _items[index]['quantity'] -= 1;
      } else {
        _items.removeAt(index);
      }
    }

    notifyListeners();
  }

  void clearBasket() {
    _items.clear();
    notifyListeners();
  }

  void removeProductCompletely(Map<String, dynamic> product) {
    items.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }
}
