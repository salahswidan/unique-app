import '../entities/poster.dart';

abstract class PosterRepository {
  Future<List<Poster>> getPosters();
  Future<Poster> createCustomPoster({
    required String imagePath,
    required String size,
    required String frame,
  });
  Future<void> addToWishlist(Poster poster);
  Future<void> removeFromWishlist(String posterId);
  Future<List<Poster>> getWishlist();
  Future<void> addToCart(Poster poster, int quantity);
  Future<void> removeFromCart(String posterId);
  Future<void> updateCartItemQuantity(String posterId, int quantity);
  Future<List<Poster>> getCart();
  Future<void> clearCart();
}
