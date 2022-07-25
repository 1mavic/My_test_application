import "package:my_app/domain/entity/api_errors/api_error.dart";

abstract class ErrorState {}

class NoErrorState extends ErrorState {}

class ErrorShowState extends ErrorState {
  final ApiError error;

  ErrorShowState(this.error);
}
