import 'cart_item.dart';

// Model for a single item within a completed order
class OrderProductItem {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final String unit;
  final String shopName;

  OrderProductItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.shopName,
  });

  // Constructor to convert CartItem to OrderProductItem
  factory OrderProductItem.fromCartItem(CartItem item) {
    final unit = item.product.category.toLowerCase() == 'food' ? 'kg' : 'pcs';
    return OrderProductItem(
      name: item.product.name,
      imageUrl: item.product.imageUrl,
      price: item.product.price,
      quantity: item.quantity,
      unit: unit,
      shopName: item.product.shopName,
    );
  }
}

// Model for the completed Order transaction
class Order {
  final String orderId;
  final DateTime date;
  final double totalAmount;
  final List<OrderProductItem> items;
  final String address;
  final String paymentMethod;
  String status; // <<< REMOVED 'final' to allow updates

  Order({
    required this.orderId,
    required this.date,
    required this.totalAmount,
    required this.items,
    required this.address,
    required this.paymentMethod,
    this.status = 'Menunggu Pembayaran',
  });
}