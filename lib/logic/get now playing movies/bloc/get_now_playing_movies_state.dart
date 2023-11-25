part of 'get_now_playing_movies_bloc.dart';

class GetNowPlayingMoviesState extends Equatable {
  const GetNowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesInitial extends GetNowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends GetNowPlayingMoviesState {
  final List<MovieModel> movies;
  final bool loadMore;

  const NowPlayingMoviesLoaded({
    this.movies = const <MovieModel>[],
    this.loadMore = false,
  });

  NowPlayingMoviesLoaded copyWith(
      {List<MovieModel>? newmovies, bool? loadMore}) {
    return NowPlayingMoviesLoaded(
      movies: newmovies ?? movies,
      loadMore: loadMore ?? this.loadMore,
    );
  }

  @override
  List<Object> get props => [movies, loadMore];
}

class ErrorOccuredNowPlayingMovies extends GetNowPlayingMoviesState {
  final String errorMsg;
  const ErrorOccuredNowPlayingMovies({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
