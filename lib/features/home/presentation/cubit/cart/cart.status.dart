part of 'cart.cubit.dart';

class CartStatus {
  final int quantity;
  final int totalprice;

  CartStatus({required this.quantity, required this.totalprice});
  CartStatus copyWith({int? quantity, int? totalprice}) {
    return CartStatus(
      quantity: quantity ?? this.quantity,
      totalprice: totalprice ?? this.totalprice,
    );
  }
}
