import 'package:equatable/equatable.dart';

class Poster extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String size;
  final String frame;
  final bool isCustom;
  final String? customImagePath;

  const Poster({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.size,
    required this.frame,
    this.isCustom = false,
    this.customImagePath,
  });

  Poster copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? price,
    String? size,
    String? frame,
    bool? isCustom,
    String? customImagePath,
  }) {
    return Poster(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      size: size ?? this.size,
      frame: frame ?? this.frame,
      isCustom: isCustom ?? this.isCustom,
      customImagePath: customImagePath ?? this.customImagePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        price,
        size,
        frame,
        isCustom,
        customImagePath,
      ];
}
