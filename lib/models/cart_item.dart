import 'product.dart';

// Model for an item inside the cart
class CartItem {
  final Product product;
  int quantity;
  final String notes;

  CartItem({required this.product, required this.quantity, this.notes = ''});
}