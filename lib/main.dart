import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/common/app_colors.dart';
import 'package:photo_app/feature/presentation/cubit/photo_list_cubit.dart';
import 'package:photo_app/feature/presentation/pages/photo_screen.dart';
import 'package:photo_app/locator_service.dart' as di;

import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(PhotoApp());
}

class PhotoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotoListCubit>(
            create: (context) => sl<PhotoListCubit>()..loadPhoto()),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
            backgroundColor: AppColors.mainBG,
            scaffoldBackgroundColor: AppColors.mainBG),
        home: HomePage(),
      ),
    );
  }
}
