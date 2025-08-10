import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/poster.dart';
import '../../domain/usecases/cart_usecases.dart';

// Events
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Poster poster;
  final int quantity;

  const AddToCart(this.poster, this.quantity);

  @override
  List<Object?> get props => [poster, quantity];
}

class RemoveFromCart extends CartEvent {
  final String posterId;

  const RemoveFromCart(this.posterId);

  @override
  List<Object?> get props => [posterId];
}

class UpdateCartItemQuantity extends CartEvent {
  final String posterId;
  final int quantity;

  const UpdateCartItemQuantity(this.posterId, this.quantity);

  @override
  List<Object?> get props => [posterId, quantity];
}

class LoadCart extends CartEvent {}

class ClearCart extends CartEvent {}

// States
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Poster> items;
  final double totalPrice;

  const CartLoaded(this.items, this.totalPrice);

  @override
  List<Object?> get props => [items, totalPrice];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateCartItemQuantityUseCase _updateCartItemQuantityUseCase;
  final GetCartUseCase _getCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CartBloc({
    required AddToCartUseCase addToCartUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase,
    required GetCartUseCase getCartUseCase,
    required ClearCartUseCase clearCartUseCase,
  })  : _addToCartUseCase = addToCartUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _updateCartItemQuantityUseCase = updateCartItemQuantityUseCase,
        _getCartUseCase = getCartUseCase,
        _clearCartUseCase = clearCartUseCase,
        super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<LoadCart>(_onLoadCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await _addToCartUseCase(event.poster, event.quantity);
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await _removeFromCartUseCase(event.posterId);
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateCartItemQuantity(UpdateCartItemQuantity event, Emitter<CartState> emit) async {
    try {
      await _updateCartItemQuantityUseCase(event.posterId, event.quantity);
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    
    try {
      final items = await _getCartUseCase();
      final totalPrice = items.fold(0.0, (sum, item) => sum + item.price);
      emit(CartLoaded(items, totalPrice));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      await _clearCartUseCase();
      emit(CartLoaded([], 0.0));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
