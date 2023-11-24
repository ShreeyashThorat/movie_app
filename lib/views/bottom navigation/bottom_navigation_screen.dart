import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/color_theme.dart';
import 'package:movie_app/utils/constant_images.dart';

import '../../logic/bottom nav/bottom_nav_cubit.dart';
import '../now playing/now_playing_screen.dart';

class BottomNavigaton extends StatefulWidget {
  const BottomNavigaton({super.key});

  @override
  State<BottomNavigaton> createState() => _BottomNavigatonState();
}

class _BottomNavigatonState extends State<BottomNavigaton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          if (state.navbarItem == NavbarItem.nowPlaying) {
            return const NowPlayingScreen();
          } else if (state.navbarItem == NavbarItem.topRated) {
            return const Center(
              child: Text("Top Rated"),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            backgroundColor: ColorTheme.primaryColor,
            currentIndex: state.index,
            selectedLabelStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
            unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorTheme.lightGrey),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(ConstantImages.nowPlayingInactive),
                activeIcon: Image.asset(
                  ConstantImages.nowPlayingActive,
                ),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(ConstantImages.topRatedInactive),
                activeIcon: Image.asset(ConstantImages.topRatedActive),
                label: 'Top Rated',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.nowPlaying);
              } else if (index == 1) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.topRated);
              }
            },
          );
        },
      ),
    );
  }
}
