part of 'country_movie_bloc.dart';

abstract class CountryMovieEvent extends Equatable {
  const CountryMovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieByCountryEvent extends CountryMovieEvent {
  final String countryId;
  GetMovieByCountryEvent({required this.countryId});
}
