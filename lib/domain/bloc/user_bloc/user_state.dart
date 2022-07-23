abstract class UserScreenState {}

class UserLoadingState extends UserScreenState {
  final String message = "loading Users";
}

class UserErrorState extends UserScreenState {
  final String error;

  UserErrorState({
    required this.error,
  });

  UserErrorState copyWith({
    String? error,
  }) {
    return UserErrorState(
      error: error ?? this.error,
    );
  }

  @override
  String toString() => "UserErrorState(error: $error)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserErrorState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class UserListObtainedState extends UserScreenState {}
