import '../entities/poster.dart';
import '../repositories/poster_repository.dart';

class AddToCartUseCase {
  final PosterRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(Poster poster, int quantity) async {
    await repository.addToCart(poster, quantity);
  }
}

class RemoveFromCartUseCase {
  final PosterRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(String posterId) async {
    await repository.removeFromCart(posterId);
  }
}

class UpdateCartItemQuantityUseCase {
  final PosterRepository repository;

  UpdateCartItemQuantityUseCase(this.repository);

  Future<void> call(String posterId, int quantity) async {
    await repository.updateCartItemQuantity(posterId, quantity);
  }
}

class GetCartUseCase {
  final PosterRepository repository;

  GetCartUseCase(this.repository);

  Future<List<Poster>> call() async {
    return await repository.getCart();
  }
}

class ClearCartUseCase {
  final PosterRepository repository;

  ClearCartUseCase(this.repository);

  Future<void> call() async {
    await repository.clearCart();
  }
}
