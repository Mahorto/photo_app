import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_app/common/app_colors.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';
import 'package:photo_app/feature/presentation/pages/photo_full_view_screen.dart';
import 'package:photo_app/feature/presentation/widget/photo_image_cache_widget.dart';

class PhotoCard extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          PhotoImageCache(
            width: 125,
            height: 125,
            imageUrl: photo.imgUrlSmall,
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => PhotoFullView(photo: photo))));
      },
    );
  }
}
