import 'dart:io';
import 'package:uuid/uuid.dart';
import '../../domain/entities/poster.dart';
import '../../domain/repositories/poster_repository.dart';
import '../../core/constants/app_constants.dart';

class PosterRepositoryImpl implements PosterRepository {
  final Uuid _uuid = const Uuid();
  
  // In-memory storage for demo purposes
  final List<Poster> _posters = [];
  final List<Poster> _wishlist = [];
  final List<Poster> _cart = [];

  PosterRepositoryImpl() {
    _initializeSamplePosters();
  }

  void _initializeSamplePosters() {
    for (int i = 0; i < 20; i++) {
      _posters.add(
        Poster(
          id: _uuid.v4(),
          title: 'Sample Poster ${i + 1}',
          imageUrl: '', // We'll use colors instead for demo
          price: 19.99 + (i * 2.5),
          size: AppConstants.mediumSize,
          frame: AppConstants.frameTypes[0],
        ),
      );
    }
  }

  @override
  Future<List<Poster>> getPosters() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _posters;
  }

  @override
  Future<Poster> createCustomPoster({
    required String imagePath,
    required String size,
    required String frame,
  }) async {
    final customPoster = Poster(
      id: _uuid.v4(),
      title: 'Custom Poster',
      imageUrl: imagePath,
      price: _calculateCustomPosterPrice(size, frame),
      size: size,
      frame: frame,
      isCustom: true,
      customImagePath: imagePath,
    );
    
    _posters.add(customPoster);
    return customPoster;
  }

  double _calculateCustomPosterPrice(String size, String frame) {
    double basePrice = 15.0;
    
    // Size multiplier
    switch (size) {
      case AppConstants.smallSize:
        basePrice *= 1.0;
        break;
      case AppConstants.mediumSize:
        basePrice *= 1.5;
        break;
      case AppConstants.largeSize:
        basePrice *= 2.0;
        break;
    }
    
    // Frame multiplier
    if (frame != AppConstants.frameTypes[0]) { // Not "No Frame"
      basePrice += 10.0;
    }
    
    return basePrice;
  }

  @override
  Future<void> addToWishlist(Poster poster) async {
    if (!_wishlist.any((item) => item.id == poster.id)) {
      _wishlist.add(poster);
    }
  }

  @override
  Future<void> removeFromWishlist(String posterId) async {
    _wishlist.removeWhere((item) => item.id == posterId);
  }

  @override
  Future<List<Poster>> getWishlist() async {
    return _wishlist;
  }

  @override
  Future<void> addToCart(Poster poster, int quantity) async {
    final existingIndex = _cart.indexWhere((item) => item.id == poster.id);
    
    if (existingIndex != -1) {
      // For demo purposes, we'll just add the poster again
      // In a real app, you'd have a CartItem entity with quantity
      _cart.add(poster);
    } else {
      // Add new item to cart
      _cart.add(poster);
    }
  }

  @override
  Future<void> removeFromCart(String posterId) async {
    _cart.removeWhere((item) => item.id == posterId);
  }

  @override
  Future<void> updateCartItemQuantity(String posterId, int quantity) async {
    final index = _cart.indexWhere((item) => item.id == posterId);
    if (index != -1) {
      if (quantity <= 0) {
        _cart.removeAt(index);
      } else {
        // For demo purposes, we'll just keep the poster
        // In a real app, you'd have a CartItem entity with quantity
      }
    }
  }

  @override
  Future<List<Poster>> getCart() async {
    return _cart;
  }

  @override
  Future<void> clearCart() async {
    _cart.clear();
  }
}
