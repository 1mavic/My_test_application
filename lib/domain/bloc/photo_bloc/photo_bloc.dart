import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/bloc/photo_bloc/photo_state.dart";
import "package:flutter_test_application/domain/entity/photo/photo_model.dart";
import "package:flutter_test_application/domain/services/photo_service.dart";

abstract class PhotoEvent {}

class GetPhotosEvent extends PhotoEvent {
  final int albumId;

  GetPhotosEvent(this.albumId);
}

class PhotoBloc extends Bloc<PhotoEvent, PhotoScreenState> {
  List<Photo> _photos = <Photo>[];

  List<Photo> get photos => _photos;

  final PhotoService _photoService;
  PhotoBloc(this._photoService) : super(PhotoLoadingState()) {
    on<GetPhotosEvent>(
        (GetPhotosEvent event, Emitter<PhotoScreenState> emit) async {
      emit(PhotoLoadingState());
      final List<Photo> _photoList =
          await _photoService.getAlbumPhotos(event.albumId);
      if (_photoList.isEmpty) {
        emit(PhotoErrorState(error: "Нет фотографий"));
        return;
      }
      _photos = _photoList;
      emit(PhotoListObtainedState());
      return;
    });
  }
}
