import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/poster_repository_impl.dart';
import '../../domain/repositories/poster_repository.dart';
import '../../domain/usecases/get_posters_usecase.dart';
import '../../domain/usecases/create_custom_poster_usecase.dart';
import '../../domain/usecases/cart_usecases.dart';
import '../../domain/usecases/wishlist_usecases.dart';
import '../../presentation/blocs/posters_bloc.dart';
import '../../presentation/blocs/cart_bloc.dart';
import '../../presentation/blocs/wishlist_bloc.dart';
import '../../presentation/blocs/custom_poster_bloc.dart';

class DependencyInjection {
  static void init() {
    // Repository
    final PosterRepository posterRepository = PosterRepositoryImpl();
    
    // Use Cases
    final GetPostersUseCase getPostersUseCase = GetPostersUseCase(posterRepository);
    final CreateCustomPosterUseCase createCustomPosterUseCase = CreateCustomPosterUseCase(posterRepository);
    
    // Cart Use Cases
    final AddToCartUseCase addToCartUseCase = AddToCartUseCase(posterRepository);
    final RemoveFromCartUseCase removeFromCartUseCase = RemoveFromCartUseCase(posterRepository);
    final UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase = UpdateCartItemQuantityUseCase(posterRepository);
    final GetCartUseCase getCartUseCase = GetCartUseCase(posterRepository);
    final ClearCartUseCase clearCartUseCase = ClearCartUseCase(posterRepository);
    
    // Wishlist Use Cases
    final AddToWishlistUseCase addToWishlistUseCase = AddToWishlistUseCase(posterRepository);
    final RemoveFromWishlistUseCase removeFromWishlistUseCase = RemoveFromWishlistUseCase(posterRepository);
    final GetWishlistUseCase getWishlistUseCase = GetWishlistUseCase(posterRepository);
    
    // BLoCs
    final PostersBloc postersBloc = PostersBloc(getPostersUseCase);
    final CartBloc cartBloc = CartBloc(
      addToCartUseCase: addToCartUseCase,
      removeFromCartUseCase: removeFromCartUseCase,
      updateCartItemQuantityUseCase: updateCartItemQuantityUseCase,
      getCartUseCase: getCartUseCase,
      clearCartUseCase: clearCartUseCase,
    );
    final WishlistBloc wishlistBloc = WishlistBloc(
      addToWishlistUseCase: addToWishlistUseCase,
      removeFromWishlistUseCase: removeFromWishlistUseCase,
      getWishlistUseCase: getWishlistUseCase,
    );
    final CustomPosterBloc customPosterBloc = CustomPosterBloc(createCustomPosterUseCase);
    
    // Store instances for access
    _instances = {
      'postersBloc': postersBloc,
      'cartBloc': cartBloc,
      'wishlistBloc': wishlistBloc,
      'customPosterBloc': customPosterBloc,
    };
  }
  
  static Map<String, dynamic> _instances = {};
  
  static T get<T>(String key) {
    return _instances[key] as T;
  }
  
  static void dispose() {
    for (final instance in _instances.values) {
      if (instance is BlocBase) {
        instance.close();
      }
    }
    _instances.clear();
  }
}
