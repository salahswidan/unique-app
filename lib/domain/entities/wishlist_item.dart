import 'package:equatable/equatable.dart';
import 'poster.dart';

class WishlistItem extends Equatable {
  final String id;
  final Poster poster;
  final DateTime addedAt;

  const WishlistItem({
    required this.id,
    required this.poster,
    required this.addedAt,
  });

  WishlistItem copyWith({
    String? id,
    Poster? poster,
    DateTime? addedAt,
  }) {
    return WishlistItem(
      id: id ?? this.id,
      poster: poster ?? this.poster,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  List<Object?> get props => [id, poster, addedAt];
}
