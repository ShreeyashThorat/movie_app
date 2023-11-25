import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/logic/get%20top%20rated%20movies/bloc/get_top_rated_movies_bloc.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../../common widgets/text_field.dart';
import '../../utils/color_theme.dart';
import '../widgets/load_movies.dart';
import '../widgets/movie_container.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  TextEditingController searchController = TextEditingController();
  final GetTopRatedMoviesBloc getTopRatedMoviesBloc = GetTopRatedMoviesBloc();
  final scrollController = ScrollController();
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get _stream => _controller.stream;

  @override
  void initState() {
    scrollController.addListener(onScroll);
    getTopRatedMoviesBloc.add(GetTopRatedMovies());
    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    getTopRatedMoviesBloc.close();
    _controller.close();
    super.dispose();
  }

  void onScroll() {
    if (isBottom) {
      getTopRatedMoviesBloc.add(GetTopRatedMovies());
    }
  }

  bool get isBottom {
    if (!scrollController.hasClients) {
      return false;
    } else {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.offset;
      return currentScroll == maxScroll;
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
            getTopRatedMoviesBloc.add(SearchTopRatedMovie(movieName: val));
          },
        ),
      ),
      body: BlocBuilder<GetTopRatedMoviesBloc, GetTopRatedMoviesState>(
        bloc: getTopRatedMoviesBloc,
        builder: (context, state) {
          if (state is GetTopRatedMoviesInitial) {
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
          if (state is ErrorOccuredTopRatedMovies) {
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
          if (state is TopRatedMoviesLoaded && state.movies.isEmpty) {
            return const Center(
              child: Text(
                "No Movies To Show",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
          }
          if (state is TopRatedMoviesLoaded && state.movies.isNotEmpty) {
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
                              getTopRatedMoviesBloc
                                  .add(DeleteTopRatedMovie(index: index));
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
    getTopRatedMoviesBloc.add(RefreshTopRatedMovie());
    _controller.sink.add(SwipeRefreshState.hidden);
  }
}
