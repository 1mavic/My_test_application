abstract class PostScreenState {}

class PostLoadingState extends PostScreenState {
  final String message = "loading posts";
}

class PostErrorState extends PostScreenState {
  final String error;

  PostErrorState({
    required this.error,
  });

  PostErrorState copyWith({
    String? error,
  }) {
    return PostErrorState(
      error: error ?? this.error,
    );
  }

  @override
  String toString() => "PostErrorState(error: $error)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostErrorState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class PostListObtainedState extends PostScreenState {}
