part of 'country_movie_bloc.dart';

abstract class CountryMovieState extends Equatable {
  const CountryMovieState();

  @override
  List<Object> get props => [];
}

class CountryMovieLoadingState extends CountryMovieState {}

class CountryMovieLoadedState extends CountryMovieLoadingState {
  final ContentByCountryModel countryModel;
  CountryMovieLoadedState({
    required this.countryModel,
  });
  @override
  List<Object> get props => [countryModel];
}

class CountryMovieErrorState extends CountryMovieLoadingState {
  final String message;
  CountryMovieErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
