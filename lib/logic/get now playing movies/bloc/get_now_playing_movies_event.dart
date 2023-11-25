part of 'get_now_playing_movies_bloc.dart';

class GetNowPlayingMoviesEvent extends Equatable {
  const GetNowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMovies extends GetNowPlayingMoviesEvent {}

class DeleteNowPlayingMovie extends GetNowPlayingMoviesEvent {
  final int index;
  const DeleteNowPlayingMovie({required this.index});

  @override
  List<Object> get props => [index];
}

class RefreshNowPlayingMovie extends GetNowPlayingMoviesEvent {}

class SearchNowPlayingMovie extends GetNowPlayingMoviesEvent {
  final String movieName;
  const SearchNowPlayingMovie({required this.movieName});
}
