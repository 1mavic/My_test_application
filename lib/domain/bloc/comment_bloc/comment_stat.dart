abstract class CommentScreenState {}

class CommentLoadingState extends CommentScreenState {
  final String message = "loading posts";
}

class CommentErrorState extends CommentScreenState {
  final String error;

  CommentErrorState({
    required this.error,
  });

  CommentErrorState copyWith({
    String? error,
  }) {
    return CommentErrorState(
      error: error ?? this.error,
    );
  }

  @override
  String toString() => "CommentErrorState(error: $error)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentErrorState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class CommentListObtainedState extends CommentScreenState {}
