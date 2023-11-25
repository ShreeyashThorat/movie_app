part of 'get_top_rated_movies_bloc.dart';

class GetTopRatedMoviesEvent extends Equatable {
  const GetTopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMovies extends GetTopRatedMoviesEvent {}

class DeleteTopRatedMovie extends GetTopRatedMoviesEvent {
  final int index;
  const DeleteTopRatedMovie({required this.index});

  @override
  List<Object> get props => [index];
}

class RefreshTopRatedMovie extends GetTopRatedMoviesEvent {}

class SearchTopRatedMovie extends GetTopRatedMoviesEvent {
  final String movieName;
  const SearchTopRatedMovie({required this.movieName});
}
