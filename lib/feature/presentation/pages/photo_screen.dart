import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_app/common/app_colors.dart';
import 'package:photo_app/feature/presentation/widget/photos_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photos',
          style: TextStyle(color: AppColors.greyColor),
        ),
        backgroundColor: AppColors.mainBG,
        centerTitle: true,
      ),
      body: PhotoList(),
    );
  }
}
