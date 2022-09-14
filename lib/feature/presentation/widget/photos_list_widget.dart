import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/common/app_colors.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';
import 'package:photo_app/feature/presentation/cubit/photo_list_cubit.dart';
import 'package:photo_app/feature/presentation/cubit/photo_list_state.dart';
import 'package:photo_app/feature/presentation/widget/photo_card_widget.dart';

class PhotoList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PhotoListCubit>().loadPhoto();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PhotoListCubit, PhotoState>(builder: ((context, state) {
      List<PhotoEntity> photos = [];
      bool isLoading = false;

      if (state is PhotoLoading && state.isFirstFetch) {
        return _loadingWidget();
      } else if (state is PhotoLoading) {
        photos = state.oldPhotoList;
        isLoading = true;
      } else if (state is PhotoLoaded) {
        photos = state.photoList;
      } else if (state is PhotoError)
        return Text(
          state.messageError,
          style: TextStyle(color: AppColors.greyColor),
        );
      return GridView.builder(
        controller: scrollController,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: ((context, index) {
          if (index < photos.length) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: PhotoCard(photo: photos[index]));
          } else {
            // Timer(Duration(microseconds: 10), (() {
            //   scrollController
            //       .jumpTo(scrollController.position.maxScrollExtent);
            // }));
            return _loadingWidget();
          }
        }),
        itemCount: photos.length + (isLoading ? 37 : 0),
      );
    }));
  }
}

Widget _loadingWidget() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Center(
      child: CircularProgressIndicator(color: AppColors.greyColor),
    ),
  );
}
