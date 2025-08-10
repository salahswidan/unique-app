import '../entities/poster.dart';
import '../repositories/poster_repository.dart';

class CreateCustomPosterUseCase {
  final PosterRepository repository;

  CreateCustomPosterUseCase(this.repository);

  Future<Poster> call({
    required String imagePath,
    required String size,
    required String frame,
  }) async {
    return await repository.createCustomPoster(
      imagePath: imagePath,
      size: size,
      frame: frame,
    );
  }
}
