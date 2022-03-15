part of 'live_tv_bloc.dart';

abstract class LiveTvEvent extends Equatable {
  const LiveTvEvent();
}

class FetchAllLiveTVData extends LiveTvEvent {
  const FetchAllLiveTVData();
  @override
  List<Object> get props => [];
}
