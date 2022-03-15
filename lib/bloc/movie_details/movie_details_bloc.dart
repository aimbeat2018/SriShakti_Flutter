import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oxoo/models/movie_details_model.dart';
import 'package:oxoo/server/repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final Repository repository;
  MovieDetailsBloc({required this.repository}) : super(MovieDetailsInitialState());

  @override
  Stream<MovieDetailsState> mapEventToState(
    MovieDetailsEvent event,
  ) async* {
    if (event is GetMovieDetailsEvent) {
      yield MovieDetailsInitialState();
      try {
        MovieDetailsModel detailsModel = await repository.getMovieDetailsData(movieId: event.movieID, userId: event.userID);
        yield MovieDetailsLoadedState(movieDetails: detailsModel);
      } catch (e) {
        yield MovieDetailsErrorState(message: e.toString());
      }
    }
  }
}
