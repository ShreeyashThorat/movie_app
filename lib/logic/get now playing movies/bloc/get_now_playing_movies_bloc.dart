import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_model.dart';

import '../../../data/repos/get_movies.dart';

part 'get_now_playing_movies_event.dart';
part 'get_now_playing_movies_state.dart';

class GetNowPlayingMoviesBloc
    extends Bloc<GetNowPlayingMoviesEvent, GetNowPlayingMoviesState> {
  int page = 1;
  GetNowPlayingMoviesBloc() : super(GetNowPlayingMoviesInitial()) {
    List<MovieModel> movies = [];
    on<GetNowPlayingMovies>((event, emit) async {
      try {
        if (state is GetNowPlayingMoviesInitial) {
          movies = await GetMovies().getNowPlayingMovies(page);
          page++;
          return emit(NowPlayingMoviesLoaded(movies: movies));
        } else if (state is NowPlayingMoviesLoaded) {
          NowPlayingMoviesLoaded nowPlayingMoviesLoaded =
              state as NowPlayingMoviesLoaded;
          final moreMovies = await GetMovies().getNowPlayingMovies(page);
          return moreMovies.isEmpty
              ? emit(nowPlayingMoviesLoaded.copyWith(loadMore: true))
              : emit(nowPlayingMoviesLoaded.copyWith(
                  newmovies: nowPlayingMoviesLoaded.movies + moreMovies,
                  loadMore: false));
        }
      } on Exception {
        return emit(const ErrorOccuredNowPlayingMovies(
            errorMsg: "Oops, Something went wrong...!"));
      }
    });

    on<DeleteNowPlayingMovie>((event, emit) async {
      movies.removeAt(event.index);
      emit(NowPlayingMoviesLoaded(movies: movies));
    });

    on<RefreshNowPlayingMovie>((event, emit) async {
      try {
        movies.clear();
        movies = await GetMovies().getNowPlayingMovies(page);
        page++;
        return emit(NowPlayingMoviesLoaded(movies: movies));
      } catch (e) {
        return emit(const ErrorOccuredNowPlayingMovies(
            errorMsg: "Oops, Something went wrong...!"));
      }
    });

    on<SearchNowPlayingMovie>((event, emit) {
      log("searched ${event.movieName}");
      if (event.movieName.isNotEmpty) {
        List<MovieModel> searchedMovie = movies
            .where((element) => element.title!
                .toLowerCase()
                .contains(event.movieName.toLowerCase()))
            .toList();
        return emit(NowPlayingMoviesLoaded(movies: searchedMovie));
      } else {
        return emit(NowPlayingMoviesLoaded(movies: movies));
      }
    });
  }
}
