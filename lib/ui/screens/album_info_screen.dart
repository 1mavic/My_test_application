import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/bloc/photo_bloc/photo_bloc.dart";
import "package:flutter_test_application/domain/bloc/photo_bloc/photo_state.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/domain/entity/photo/photo_model.dart";
import "package:flutter_test_application/styles/app_colors.dart";
import "package:flutter_test_application/ui/widgets/card_widget.dart";
import "package:flutter_test_application/ui/widgets/image_widget.dart";
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";

class AlbumInfoScreen extends StatelessWidget {
  const AlbumInfoScreen({Key? key, required this.album}) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: "Альбом",
      body: Column(
        children: <Widget>[
          Text("Album: ${album.title}"),
          const SizedBox(
            height: 20,
          ),
          const _AlbumdPhotosWidget()
        ],
      ),
    );
  }
}

class _AlbumdPhotosWidget extends StatelessWidget {
  const _AlbumdPhotosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoScreenState>(
      builder: (BuildContext context, PhotoScreenState state) {
        switch (state.runtimeType) {
          case PhotoLoadingState:
            return const SizedBox.square(
              dimension: 200,
              child: CircularProgressIndicator.adaptive(),
            );
          case PhotoErrorState:
            final PhotoErrorState _state = state as PhotoErrorState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _state.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          case PhotoListObtainedState:
            final List<Photo> _photos = context.watch<PhotoBloc>().photos;
            if (_photos.isEmpty) {
              return const SizedBox.shrink();
            }
            final List<Widget> _photosForSlider = _photos
                .map(
                  (Photo photo) => Stack(
                    children: <Widget>[
                      ImageWidget(
                        url: photo.url,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Text(
                          photo.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.white),
                        ),
                      )
                    ],
                  ),
                )
                .toList();
            return CarouselSlider(
              items: _photosForSlider,
              options: CarouselOptions(
                //height: 201.94,
                aspectRatio: 359 / 220,
                viewportFraction: 0.93,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
