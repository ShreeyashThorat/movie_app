part of 'get_top_rated_movies_bloc.dart';

class GetTopRatedMoviesState extends Equatable {
  const GetTopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class GetTopRatedMoviesInitial extends GetTopRatedMoviesState {}

class TopRatedMoviesLoaded extends GetTopRatedMoviesState {
  final List<MovieModel> movies;
  final bool loadMore;

  const TopRatedMoviesLoaded({
    this.movies = const <MovieModel>[],
    this.loadMore = false,
  });

  TopRatedMoviesLoaded copyWith({List<MovieModel>? newMovies, bool? loadMore}) {
    return TopRatedMoviesLoaded(
      movies: newMovies ?? movies,
      loadMore: loadMore ?? this.loadMore,
    );
  }

  @override
  List<Object> get props => [movies, loadMore];
}

class ErrorOccuredTopRatedMovies extends GetTopRatedMoviesState {
  final String errorMsg;
  const ErrorOccuredTopRatedMovies({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
