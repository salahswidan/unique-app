import '../entities/poster.dart';
import '../repositories/poster_repository.dart';

class AddToWishlistUseCase {
  final PosterRepository repository;

  AddToWishlistUseCase(this.repository);

  Future<void> call(Poster poster) async {
    await repository.addToWishlist(poster);
  }
}

class RemoveFromWishlistUseCase {
  final PosterRepository repository;

  RemoveFromWishlistUseCase(this.repository);

  Future<void> call(String posterId) async {
    await repository.removeFromWishlist(posterId);
  }
}

class GetWishlistUseCase {
  final PosterRepository repository;

  GetWishlistUseCase(this.repository);

  Future<List<Poster>> call() async {
    return await repository.getWishlist();
  }
}
