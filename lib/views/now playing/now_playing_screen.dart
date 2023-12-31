import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/logic/get%20now%20playing%20movies/bloc/get_now_playing_movies_bloc.dart';
import 'package:movie_app/utils/color_theme.dart';
import 'package:movie_app/views/widgets/load_movies.dart';
import 'package:movie_app/views/widgets/movie_container.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../../common widgets/text_field.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  TextEditingController searchController = TextEditingController();
  final GetNowPlayingMoviesBloc getNowPlayingMoviesBloc =
      GetNowPlayingMoviesBloc();
  final scrollController = ScrollController();
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get _stream => _controller.stream;

  @override
  void initState() {
    scrollController.addListener(onScroll);
    getNowPlayingMoviesBloc.add(GetNowPlayingMovies());
    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    getNowPlayingMoviesBloc.close();
    _controller.close();
    super.dispose();
  }

  void onScroll() {
    if (isBottom) {
      getNowPlayingMoviesBloc.add(GetNowPlayingMovies());
    }
  }

  bool get isBottom {
    if (!scrollController.hasClients) {
      return false;
    } else {
      if (searchController.text.isEmpty) {
        final maxScroll = scrollController.position.maxScrollExtent;
        final currentScroll = scrollController.offset;
        return currentScroll == maxScroll;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.primaryColor,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.3),
        automaticallyImplyLeading: false,
        title: MyTextField(
          radius: 10,
          controller: searchController,
          hintText: "Search",
          fillColor: Colors.white,
          filled: true,
          verticalPadding: 10,
          preffix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search_rounded,
              size: 20,
              color: ColorTheme.hintText,
            ),
          ),
          onChange: (val) {
            getNowPlayingMoviesBloc.add(SearchNowPlayingMovie(movieName: val));
          },
        ),
      ),
      body: BlocBuilder<GetNowPlayingMoviesBloc, GetNowPlayingMoviesState>(
        bloc: getNowPlayingMoviesBloc,
        builder: (context, state) {
          if (state is GetNowPlayingMoviesInitial) {
            return ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.015),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return const LoadMovies();
                });
          }
          if (state is ErrorOccuredNowPlayingMovies) {
            return Center(
              child: Text(
                state.errorMsg,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
          }
          if (state is NowPlayingMoviesLoaded && state.movies.isEmpty) {
            return const Center(
              child: Text(
                "No More Movies To Show",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
          }
          if (state is NowPlayingMoviesLoaded && state.movies.isNotEmpty) {
            return SwipeRefresh.cupertino(
                stateStream: _stream,
                onRefresh: _refresh,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.015),
                scrollController: scrollController,
                children: [
                  ...List.generate(
                      state.loadMore == true
                          ? state.movies.length
                          : state.movies.length + 1, (index) {
                    return index >= state.movies.length
                        ? Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: const Center(
                              child: SpinKitThreeBounce(
                                color: Colors.black,
                                size: 25,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                          )
                        : Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              getNowPlayingMoviesBloc
                                  .add(DeleteNowPlayingMovie(index: index));
                              log("$direction");
                            },
                            child: MovieContainer(movie: state.movies[index]));
                  })
                ]);
          }
          return Container();
        },
      ),
    );
  }

  Future<void> _refresh() async {
    getNowPlayingMoviesBloc.add(RefreshNowPlayingMovie());
    _controller.sink.add(SwipeRefreshState.hidden);
  }
}
