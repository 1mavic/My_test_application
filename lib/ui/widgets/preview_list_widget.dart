import "package:flutter/material.dart";
import "package:my_app/domain/entity/album/album_model.dart";
import "package:my_app/domain/entity/post/post_model.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/styles/app_colors.dart";
import "package:my_app/ui/widgets/card_widget.dart";
import "package:my_app/utils/string_extensions.dart";

class PreviewWidget<T> extends StatelessWidget {
  const PreviewWidget({
    super.key,
    required this.items,
    required this.small,
    required this.routeToDetail,
    required this.routeToList,
  });
  final List<T> items;
  final String routeToDetail;
  final String routeToList;
  final bool small;
  @override
  Widget build(BuildContext context) {
    final int length = small
        ? items.length > 3
            ? 3
            : items.length
        : items.length;
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    final Widget bodyList = CardWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            separatorBuilder: (_, __) => Divider(
              height: small ? 15 : 20,
              color: AppColors.blue,
            ),
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                if (small) {
                  return;
                }
                Navigator.of(context)
                    .pushNamed(routeToDetail, arguments: items[index]);
              },
              child: _ItemPreviewWidget<T>(
                item: items[index],
              ),
            ),
          ),
          if (small) const SizedBox(height: 10),
          if (small && items.length > 3)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    routeToList,
                    arguments: items,
                  );
                },
                child: Text(
                  context.localize(AppLocKeys.seeAll).firstToUpper(),
                ),
              ),
            )
        ],
      ),
    );

    return small
        ? bodyList
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: bodyList,
          );
  }
}

class _ItemPreviewWidget<T> extends StatelessWidget {
  const _ItemPreviewWidget({super.key, required this.item});
  final T item;
  @override
  Widget build(BuildContext context) {
    String? title;
    String? body;
    if (T == Post) {
      final Post post = item as Post;
      title = post.title;
      body = post.body.split("\n").first;
    } else if (T == Album) {
      final Album album = item as Album;
      title = album.title;
      body = null;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) Text(title),
        if (title != null && body != null) const SizedBox(height: 5),
        if (body != null)
          Text(
            body,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
