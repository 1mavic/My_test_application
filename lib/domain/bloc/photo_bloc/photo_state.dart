abstract class PhotoScreenState {}

class PhotoLoadingState extends PhotoScreenState {
  final String message = "loading Photos";
}

class PhotoErrorState extends PhotoScreenState {
  final String error;

  PhotoErrorState({
    required this.error,
  });

  PhotoErrorState copyWith({
    String? error,
  }) {
    return PhotoErrorState(
      error: error ?? this.error,
    );
  }

  @override
  String toString() => "PhotoErrorState(error: $error)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhotoErrorState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class PhotoListObtainedState extends PhotoScreenState {}
