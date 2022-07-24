import 'dart:async';

import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/bloc/error_bloc/error_bloc_state.dart";
import "package:flutter_test_application/domain/data_providers/api_cleint/api_repository.dart";
import "package:flutter_test_application/domain/entity/api_errors/api_error.dart";

abstract class ErrorEvent {}

class ShowErrorEvent extends ErrorEvent {
  final ApiError error;

  ShowErrorEvent(this.error);
}

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  final ApiRepository _apiRepository;
  StreamSubscription<ApiError>? _subscription;
  ErrorBloc(this._apiRepository) : super(NoErrorState()) {
    _subscription = _apiRepository.errorStream.listen((ApiError event) {
      add(ShowErrorEvent(event));
    });
    on<ShowErrorEvent>((ShowErrorEvent event, Emitter<ErrorState> emit) {
      emit(ErrorShowState(event.error));
      emit(NoErrorState());
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
