part of 'movie_details_bloc.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoadedState extends MovieDetailsState {
  final MovieDetailsModel movieDetails;

  MovieDetailsLoadedState({
    required this.movieDetails,
  });

  MovieDetailsModel getMovieDetails() {
    return movieDetails;
  }

  @override
  List<Object> get props => [movieDetails];
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String message;
  MovieDetailsErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
