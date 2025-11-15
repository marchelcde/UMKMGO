import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart'; // <<< FIX: Import the new model

// --- REMOVE THE CartItem CLASS DEFINITION FROM THIS FILE ---
// (If you still have 'class CartItem { ... }' here, delete it)

// Global Cart State Manager
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Calculates the total price of all items in the cart
  double get subtotal {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  // Calculates the total number of units across all items
  int get totalQuantity {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Find an item in the cart by product name
  CartItem? _findItem(Product product) {
    try {
      return _items.firstWhere((item) => item.product.name == product.name);
    } catch (e) {
      return null;
    }
  }

  // --- Actions ---

  void addToCart(Product product, {int quantity = 1}) {
    final existingItem = _findItem(product);

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    final item = _findItem(product);
    if (item != null) {
      item.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(Product product) {
    final item = _findItem(product);
    if (item != null) {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        // Remove item if quantity drops to 0
        _items.remove(item);
      }
      notifyListeners();
    }
  }

  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}