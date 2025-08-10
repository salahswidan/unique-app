import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/poster.dart';
import '../../domain/usecases/wishlist_usecases.dart';

// Events
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final Poster poster;

  const AddToWishlist(this.poster);

  @override
  List<Object?> get props => [poster];
}

class RemoveFromWishlist extends WishlistEvent {
  final String posterId;

  const RemoveFromWishlist(this.posterId);

  @override
  List<Object?> get props => [posterId];
}

class LoadWishlist extends WishlistEvent {}

// States
abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Poster> items;

  const WishlistLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final AddToWishlistUseCase _addToWishlistUseCase;
  final RemoveFromWishlistUseCase _removeFromWishlistUseCase;
  final GetWishlistUseCase _getWishlistUseCase;

  WishlistBloc({
    required AddToWishlistUseCase addToWishlistUseCase,
    required RemoveFromWishlistUseCase removeFromWishlistUseCase,
    required GetWishlistUseCase getWishlistUseCase,
  })  : _addToWishlistUseCase = addToWishlistUseCase,
        _removeFromWishlistUseCase = removeFromWishlistUseCase,
        _getWishlistUseCase = getWishlistUseCase,
        super(WishlistInitial()) {
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<LoadWishlist>(_onLoadWishlist);
  }

  Future<void> _onAddToWishlist(AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      await _addToWishlistUseCase(event.poster);
      add(LoadWishlist());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(RemoveFromWishlist event, Emitter<WishlistState> emit) async {
    try {
      await _removeFromWishlistUseCase(event.posterId);
      add(LoadWishlist());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onLoadWishlist(LoadWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    
    try {
      final items = await _getWishlistUseCase();
      emit(WishlistLoaded(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}
