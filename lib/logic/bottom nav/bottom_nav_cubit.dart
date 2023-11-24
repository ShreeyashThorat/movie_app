import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(NavbarItem.nowPlaying, 0));
  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.nowPlaying:
        emit(const BottomNavState(NavbarItem.nowPlaying, 0));
        break;
      case NavbarItem.topRated:
        emit(const BottomNavState(NavbarItem.topRated, 1));
        break;
    }
  }
}

enum NavbarItem { nowPlaying, topRated }

class BottomNavState extends Equatable {
  final NavbarItem navbarItem;
  final int index;
  const BottomNavState(this.navbarItem, this.index);
  @override
  List<Object> get props => [navbarItem, index];
}
