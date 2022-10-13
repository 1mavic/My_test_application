import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/domain/bloc/photo_bloc/photo_state.dart";
import "package:my_app/domain/entity/photo/photo_model.dart";
import "package:my_app/domain/services/photo_service.dart";

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
      final List<Photo> photoList =
          await _photoService.getAlbumPhotos(event.albumId);
      if (photoList.isEmpty) {
        emit(PhotoErrorState(error: "Нет фотографий"));
        return;
      }
      _photos = photoList;
      emit(PhotoListObtainedState());
      return;
    });
  }
}
