import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/movie_model.dart';
import '../../../data/repos/get_movies.dart';

part 'get_top_rated_movies_event.dart';
part 'get_top_rated_movies_state.dart';

class GetTopRatedMoviesBloc
    extends Bloc<GetTopRatedMoviesEvent, GetTopRatedMoviesState> {
  int page = 1;
  GetTopRatedMoviesBloc() : super(GetTopRatedMoviesInitial()) {
    List<MovieModel> movies = [];
    on<GetTopRatedMovies>((event, emit) async {
      try {
        if (state is GetTopRatedMoviesInitial) {
          movies = await GetMovies().getTopRatedMovies(page);
          page++;
          return emit(TopRatedMoviesLoaded(movies: movies));
        } else if (state is TopRatedMoviesLoaded) {
          TopRatedMoviesLoaded topRatedMoviesLoaded =
              state as TopRatedMoviesLoaded;
          final moreMovies = await GetMovies().getTopRatedMovies(page);
          return moreMovies.isEmpty
              ? emit(topRatedMoviesLoaded.copyWith(loadMore: true))
              : emit(topRatedMoviesLoaded.copyWith(
                  newMovies: topRatedMoviesLoaded.movies + moreMovies));
        }
      } catch (e, stacktrace) {
        log(e.toString());
        log(stacktrace.toString());
        return emit(const ErrorOccuredTopRatedMovies(
            errorMsg: "Oops, Something went wrong...!"));
      }
    });

    on<DeleteTopRatedMovie>((event, emit) async {
      movies.removeAt(event.index);
      emit(TopRatedMoviesLoaded(movies: movies));
    });

    on<RefreshTopRatedMovie>((event, emit) async {
      try {
        movies.clear();
        movies = await GetMovies().getTopRatedMovies(page);
        page++;
        return emit(TopRatedMoviesLoaded(movies: movies));
      } catch (e) {
        return emit(const ErrorOccuredTopRatedMovies(
            errorMsg: "Oops, Something went wrong...!"));
      }
    });

    on<SearchTopRatedMovie>((event, emit) {
      log("searched ${event.movieName}");
      if (event.movieName.isNotEmpty) {
        List<MovieModel> searchedMovie = movies
            .where((element) => element.title!
                .toLowerCase()
                .contains(event.movieName.toLowerCase()))
            .toList();
        return emit(TopRatedMoviesLoaded(movies: searchedMovie));
      } else {
        return emit(TopRatedMoviesLoaded(movies: movies));
      }
    });
  }
}
