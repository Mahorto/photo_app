import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_app/common/app_colors.dart';

class PhotoImageCache extends StatelessWidget {
  final String imageUrl;
  final double width, height;

  const PhotoImageCache(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height});

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      imageBuilder: ((context, imageProvider) {
        return _imageWidget(imageProvider);
      }),
      errorWidget: ((context, url, error) {
        return _imageWidget(AssetImage('assets/img/noimage.jpg'));
      }),
    );
  }
}
