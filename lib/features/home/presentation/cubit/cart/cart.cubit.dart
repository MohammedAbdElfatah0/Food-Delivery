import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart.status.dart';

class CartCubit extends Cubit<CartStatus> {
  final int price;
  CartCubit({required this.price})
    : super(CartStatus(quantity: 1, totalprice: price));

  void incrementPrice() {
    final newQuantity = state.quantity + 1;
    emit(
      state.copyWith(quantity: newQuantity, totalprice: newQuantity * price),
    );
  }

  void decrementPrice() {
    if (state.quantity > 1) {
      final newQuantity = state.quantity - 1;
      emit(
        state.copyWith(quantity: newQuantity, totalprice: price * newQuantity),
      );
    }
  }
}
