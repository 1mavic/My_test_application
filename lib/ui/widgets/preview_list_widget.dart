import "package:flutter/material.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/localization/app_locale_keys.dart";
import "package:flutter_test_application/localization/app_localization.dart";
import "package:flutter_test_application/styles/app_colors.dart";
import "package:flutter_test_application/ui/widgets/card_widget.dart";
import "package:flutter_test_application/utils/string_extensions.dart";

class PreviewWidget<T> extends StatelessWidget {
  const PreviewWidget({
    Key? key,
    required this.items,
    required this.small,
    required this.routeToDetail,
    required this.routeToList,
  }) : super(key: key);
  final List<T> items;
  final String routeToDetail;
  final String routeToList;
  final bool small;
  @override
  Widget build(BuildContext context) {
    final int _length = small
        ? items.length > 3
            ? 3
            : items.length
        : items.length;
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    final Widget _bodyList = CardWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _length,
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
                  context.localize(AppLocKeys.userList).firstToUpper(),
                ),
              ),
            )
        ],
      ),
    );

    return small
        ? _bodyList
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _bodyList,
          );
  }
}

class _ItemPreviewWidget<T> extends StatelessWidget {
  const _ItemPreviewWidget({Key? key, required this.item}) : super(key: key);
  final T item;
  @override
  Widget build(BuildContext context) {
    String? _title;
    String? _body;
    if (T == Post) {
      final Post post = item as Post;
      _title = post.title;
      _body = post.body.split("\n").first;
    } else if (T == Album) {
      final Album album = item as Album;
      _title = album.title;
      _body = null;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (_title != null) Text(_title),
        if (_title != null && _body != null) const SizedBox(height: 5),
        if (_body != null)
          Text(
            _body,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
