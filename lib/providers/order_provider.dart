import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _pastOrders = [];

  List<Order> get pastOrders => _pastOrders;

  void addOrder(Order order) {
    _pastOrders.insert(0, order); // Add new orders to the front
    notifyListeners();
  }

  // --- NEW METHOD ---
  /// Finds an order by its ID and updates its status.
  void updateOrderStatus(String orderId, String newStatus) {
    try {
      final order = _pastOrders.firstWhere((order) => order.orderId == orderId);
      order.status = newStatus;
      notifyListeners();
    } catch (e) {
      // Handle error if order not found
      print('Error updating order status: $e');
    }
  }
}