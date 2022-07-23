abstract class AlbumScreenState {}

class AlbumLoadingState extends AlbumScreenState {
  final String message = "loading Albums";
}

class AlbumErrorState extends AlbumScreenState {
  final String error;

  AlbumErrorState({
    required this.error,
  });

  AlbumErrorState copyWith({
    String? error,
  }) {
    return AlbumErrorState(
      error: error ?? this.error,
    );
  }

  @override
  String toString() => "AlbumErrorState(error: $error)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlbumErrorState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class AlbumListObtainedState extends AlbumScreenState {}
