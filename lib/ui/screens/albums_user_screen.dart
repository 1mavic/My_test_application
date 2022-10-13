import "package:flutter/material.dart";
import "package:my_app/domain/entity/album/album_model.dart";
import "package:my_app/navigation/routes.dart";
// ignore: prefer_double_quotes
import 'package:my_app/ui/widgets/preview_list_widget.dart';
import "package:my_app/ui/widgets/scaffold_template_widget.dart";

class UserAlbumsScreen extends StatelessWidget {
  const UserAlbumsScreen({super.key, required this.albums});
  final List<Album> albums;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: "Все альбомы",
      body: PreviewWidget<Album>(
        items: albums,
        routeToList: AppRoutes.userAlbums,
        routeToDetail: AppRoutes.userAlbumInfo,
        small: false,
      ),
    );
  }
}
