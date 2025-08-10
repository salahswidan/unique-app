import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/poster.dart';
import '../../domain/usecases/create_custom_poster_usecase.dart';
import '../../core/constants/app_constants.dart';

// Events
abstract class CustomPosterEvent extends Equatable {
  const CustomPosterEvent();

  @override
  List<Object?> get props => [];
}

class SelectImage extends CustomPosterEvent {
  final String imagePath;

  const SelectImage(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class SelectSize extends CustomPosterEvent {
  final String size;

  const SelectSize(this.size);

  @override
  List<Object?> get props => [size];
}

class SelectFrame extends CustomPosterEvent {
  final String frame;

  const SelectFrame(this.frame);

  @override
  List<Object?> get props => [frame];
}

class CreateCustomPoster extends CustomPosterEvent {}

class ResetCustomPoster extends CustomPosterEvent {}

// States
abstract class CustomPosterState extends Equatable {
  const CustomPosterState();

  @override
  List<Object?> get props => [];
}

class CustomPosterInitial extends CustomPosterState {}

class CustomPosterLoading extends CustomPosterState {}

class CustomPosterCreated extends CustomPosterState {
  final Poster poster;

  const CustomPosterCreated(this.poster);

  @override
  List<Object?> get props => [poster];
}

class CustomPosterError extends CustomPosterState {
  final String message;

  const CustomPosterError(this.message);

  @override
  List<Object?> get props => [message];
}

class CustomPosterInProgress extends CustomPosterState {
  final String? selectedImagePath;
  final String selectedSize;
  final String selectedFrame;
  final double currentPrice;

  const CustomPosterInProgress({
    this.selectedImagePath,
    this.selectedSize = AppConstants.mediumSize,
    this.selectedFrame = 'No Frame',
    this.currentPrice = 22.5, // Base price for medium size
  });

  CustomPosterInProgress copyWith({
    String? selectedImagePath,
    String? selectedSize,
    String? selectedFrame,
    double? currentPrice,
  }) {
    return CustomPosterInProgress(
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedFrame: selectedFrame ?? this.selectedFrame,
      currentPrice: currentPrice ?? this.currentPrice,
    );
  }

  @override
  List<Object?> get props => [
        selectedImagePath,
        selectedSize,
        selectedFrame,
        currentPrice,
      ];
}

// BLoC
class CustomPosterBloc extends Bloc<CustomPosterEvent, CustomPosterState> {
  final CreateCustomPosterUseCase _createCustomPosterUseCase;

  CustomPosterBloc(this._createCustomPosterUseCase) : super(CustomPosterInitial()) {
    on<SelectImage>(_onSelectImage);
    on<SelectSize>(_onSelectSize);
    on<SelectFrame>(_onSelectFrame);
    on<CreateCustomPoster>(_onCreateCustomPoster);
    on<ResetCustomPoster>(_onResetCustomPoster);
  }

  void _onSelectImage(SelectImage event, Emitter<CustomPosterState> emit) {
    if (state is CustomPosterInProgress) {
      final currentState = state as CustomPosterInProgress;
      emit(currentState.copyWith(selectedImagePath: event.imagePath));
    } else {
      emit(CustomPosterInProgress(selectedImagePath: event.imagePath));
    }
  }

  void _onSelectSize(SelectSize event, Emitter<CustomPosterState> emit) {
    if (state is CustomPosterInProgress) {
      final currentState = state as CustomPosterInProgress;
      final newPrice = _calculatePrice(event.size, currentState.selectedFrame);
      emit(currentState.copyWith(
        selectedSize: event.size,
        currentPrice: newPrice,
      ));
    } else {
      final newPrice = _calculatePrice(event.size, AppConstants.frameTypes[0]);
      emit(CustomPosterInProgress(
        selectedSize: event.size,
        currentPrice: newPrice,
      ));
    }
  }

  void _onSelectFrame(SelectFrame event, Emitter<CustomPosterState> emit) {
    if (state is CustomPosterInProgress) {
      final currentState = state as CustomPosterInProgress;
      final newPrice = _calculatePrice(currentState.selectedSize, event.frame);
      emit(currentState.copyWith(
        selectedFrame: event.frame,
        currentPrice: newPrice,
      ));
    } else {
      final newPrice = _calculatePrice(AppConstants.mediumSize, event.frame);
      emit(CustomPosterInProgress(
        selectedFrame: event.frame,
        currentPrice: newPrice,
      ));
    }
  }

  double _calculatePrice(String size, String frame) {
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

  Future<void> _onCreateCustomPoster(CreateCustomPoster event, Emitter<CustomPosterState> emit) async {
    if (state is CustomPosterInProgress) {
      final currentState = state as CustomPosterInProgress;
      
      if (currentState.selectedImagePath == null) {
        emit(const CustomPosterError('Please select an image first'));
        return;
      }

      emit(CustomPosterLoading());
      
      try {
        final poster = await _createCustomPosterUseCase(
          imagePath: currentState.selectedImagePath!,
          size: currentState.selectedSize,
          frame: currentState.selectedFrame,
        );
        emit(CustomPosterCreated(poster));
      } catch (e) {
        emit(CustomPosterError(e.toString()));
      }
    }
  }

  void _onResetCustomPoster(ResetCustomPoster event, Emitter<CustomPosterState> emit) {
    emit(CustomPosterInitial());
  }
}
