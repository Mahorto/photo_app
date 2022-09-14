import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_app/common/app_colors.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';
import 'package:photo_app/feature/presentation/widget/photo_image_cache_widget.dart';

class PhotoFullView extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoFullView({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Photos',
        style: TextStyle(color: AppColors.greyColor),
      )),
      body: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: PhotoImageCache(
                imageUrl: photo.imgUrlFull,
                width: photo.width.toDouble(),
                height: photo.height.toDouble(),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Container(
                alignment: Alignment.bottomCenter,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Text(
                  photo.description,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      backgroundColor: Color.fromARGB(86, 74, 74, 74)),
                )),
          ),
        ],
      ),
    );
  }
}
