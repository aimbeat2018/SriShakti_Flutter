import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/tv_series_details_model.dart';
import '../../server/repository.dart';

class TvSerisEvent {}

class GetTvSerisEvent extends TvSerisEvent {
  @required
  final seriesId;
  @required
  final userId;
  GetTvSerisEvent({this.seriesId, this.userId});
}

class TvSerisState {}

class TvSerisInitailState extends TvSerisState {}

class TvSerisIsNotLoading extends TvSerisState {}

class TvSerisIsLoaded extends TvSerisState {
  TvSeriesDetailsModel? tvSeriesDetailsModel;
  TvSerisIsLoaded({this.tvSeriesDetailsModel});
}

class TvSerisErrorState extends TvSerisState {
  final error;
  TvSerisErrorState({this.error});
}

class TvSerisBloc extends Bloc<TvSerisEvent, TvSerisState> {
  Repository repository;
  TvSerisBloc(this.repository) : super(TvSerisInitailState());

  TvSerisState get initialState => TvSerisInitailState();

  @override
  Stream<TvSerisState> mapEventToState(TvSerisEvent event) async* {
    if (event is GetTvSerisEvent) {
      yield TvSerisInitailState();
      try {
        TvSeriesDetailsModel? tvSeriesDetailsModel =
            await repository.getTvSeriesDetailsData(
                seriesId: event.seriesId, userId: event.userId);
        yield TvSerisIsLoaded(tvSeriesDetailsModel: tvSeriesDetailsModel);
      } catch (e) {
        yield TvSerisErrorState(error: e.toString());
      }
    }
  }
}
