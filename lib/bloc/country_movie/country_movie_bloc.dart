import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oxoo/models/content_by_country_model.dart';

import 'package:oxoo/server/repository.dart';

part 'country_movie_event.dart';
part 'country_movie_state.dart';

class CountryMovieBloc extends Bloc<CountryMovieEvent, CountryMovieState> {
  final Repository repository;
  CountryMovieBloc({
    required this.repository,
  }) : super(CountryMovieLoadingState());

  @override
  Stream<CountryMovieState> mapEventToState(
    CountryMovieEvent event,
  ) async* {
    if (event is GetMovieByCountryEvent) {
      yield CountryMovieLoadingState();
      try {
        ContentByCountryModel contentByCountryModel = await repository.contentByCountry(countryID: event.countryId);
        yield CountryMovieLoadedState(countryModel: contentByCountryModel);
      } catch (e) {
        yield CountryMovieErrorState(message: "Country Data error.");
      }
    }
  }
}
