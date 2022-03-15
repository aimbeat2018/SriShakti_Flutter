import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/search_result_model.dart';
import '../../server/repository.dart';

class SearchEvent {}

class GetSearchEvent extends SearchEvent {
  @required
  final param;
  GetSearchEvent({this.param});
}

class SearchState {}

class SearchInitailState extends SearchState {}

class SearchIsNotLoading extends SearchState {}

class SearchIsLoaded extends SearchState {
  SearchResultModel? searchResultModel;
  SearchIsLoaded({this.searchResultModel});
}

class SearchErrorState extends SearchState {
  final error;
  SearchErrorState({this.error});
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  Repository repository;
  SearchBloc(this.repository) : super(SearchInitailState());

  SearchState get initialState => SearchInitailState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is GetSearchEvent) {
      yield SearchInitailState();
      try {
        SearchResultModel? searchResultModel =
            await repository.searchResultData(query: event.param);
        yield SearchIsLoaded(searchResultModel: searchResultModel);
      } catch (e) {
        yield SearchErrorState(error: e.toString());
      }
    }
  }
}
