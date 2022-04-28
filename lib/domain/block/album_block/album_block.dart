import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/block/album_block/album_state.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/domain/services/album_service.dart";

abstract class AlbumEvent {}

class GetAlbumsEvent extends AlbumEvent {
  final int userId;

  GetAlbumsEvent(this.userId);
}

class AlbumBlock extends Bloc<AlbumEvent, AlbumScreenState> {
  List<Album> _albums = <Album>[];

  List<Album> get albums => _albums;

  final AlbumService _albumService = AlbumService();
  AlbumBlock() : super(AlbumLoadingState()) {
    on<GetAlbumsEvent>(
        (GetAlbumsEvent event, Emitter<AlbumScreenState> emit) async {
      emit(AlbumLoadingState());
      final List<Album> _albumList =
          await _albumService.getUserAlbum(event.userId);
      if (_albumList.isEmpty) {
        emit(AlbumErrorState(error: "Получен пустой список альбомов"));
        return;
      }
      _albums = _albumList;
      emit(AlbumListObtainedState());
      return;
    });
  }
}
