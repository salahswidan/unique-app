import 'package:equatable/equatable.dart';
import 'poster.dart';

class CartItem extends Equatable {
  final String id;
  final Poster poster;
  final int quantity;

  const CartItem({
    required this.id,
    required this.poster,
    required this.quantity,
  });

  double get totalPrice => poster.price * quantity;

  CartItem copyWith({
    String? id,
    Poster? poster,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      poster: poster ?? this.poster,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, poster, quantity];
}
