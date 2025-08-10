import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/poster.dart';
import '../../domain/usecases/get_posters_usecase.dart';

// Events
abstract class PostersEvent extends Equatable {
  const PostersEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosters extends PostersEvent {}

class RefreshPosters extends PostersEvent {}

// States
abstract class PostersState extends Equatable {
  const PostersState();

  @override
  List<Object?> get props => [];
}

class PostersInitial extends PostersState {}

class PostersLoading extends PostersState {}

class PostersLoaded extends PostersState {
  final List<Poster> posters;

  const PostersLoaded(this.posters);

  @override
  List<Object?> get props => [posters];
}

class PostersError extends PostersState {
  final String message;

  const PostersError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class PostersBloc extends Bloc<PostersEvent, PostersState> {
  final GetPostersUseCase _getPostersUseCase;

  PostersBloc(this._getPostersUseCase) : super(PostersInitial()) {
    on<LoadPosters>(_onLoadPosters);
    on<RefreshPosters>(_onRefreshPosters);
  }

  Future<void> _onLoadPosters(LoadPosters event, Emitter<PostersState> emit) async {
    emit(PostersLoading());
    
    try {
      final posters = await _getPostersUseCase();
      emit(PostersLoaded(posters));
    } catch (e) {
      emit(PostersError(e.toString()));
    }
  }

  Future<void> _onRefreshPosters(RefreshPosters event, Emitter<PostersState> emit) async {
    try {
      final posters = await _getPostersUseCase();
      emit(PostersLoaded(posters));
    } catch (e) {
      emit(PostersError(e.toString()));
    }
  }
}
