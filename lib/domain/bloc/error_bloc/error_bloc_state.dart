import 'package:flutter_test_application/domain/entity/api_errors/api_error.dart';

abstract class ErrorState {}

class NoErrorState extends ErrorState {}

class ErrorShowState extends ErrorState {
  final ApiError error;

  ErrorShowState(this.error);
}
