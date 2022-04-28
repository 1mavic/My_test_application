import "package:flutter/material.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import 'package:flutter_test_application/ui/widgets/preview_list_widget.dart';
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";

class UserAlbumsScreen extends StatelessWidget {
  const UserAlbumsScreen({Key? key, required this.albums}) : super(key: key);
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
