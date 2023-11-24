import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/color_theme.dart';

import 'logic/bottom nav/bottom_nav_cubit.dart';
import 'views/bottom navigation/bottom_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorTheme.primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        ),
        debugShowCheckedModeBanner: false,
        home: const BottomNavigaton(),
      ),
    );
  }
}
