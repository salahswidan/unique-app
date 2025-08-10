import '../entities/poster.dart';
import '../repositories/poster_repository.dart';

class GetPostersUseCase {
  final PosterRepository repository;

  GetPostersUseCase(this.repository);

  Future<List<Poster>> call() async {
    return await repository.getPosters();
  }
}
