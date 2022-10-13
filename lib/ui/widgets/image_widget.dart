import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:my_app/styles/app_colors.dart";

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.contain,
      placeholder: (_, __) => Container(
        height: 150,
        width: 200,
        color: AppColors.blue,
        child: const CircularProgressIndicator.adaptive(),
      ),
      errorWidget: (BuildContext context, String? error, _) => Container(
        height: 150,
        width: 200,
        color: AppColors.blue,
      ),
    );
  }
}
