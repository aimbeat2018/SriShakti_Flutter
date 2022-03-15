part of 'live_tv_bloc.dart';

abstract class LiveTvState extends Equatable {
  const LiveTvState();

  @override
  List<Object> get props => [];
}

class LiveTvInitial extends LiveTvState {}

class LiveTvLoadingState extends LiveTvState {}

class LiveTvErrorState extends LiveTvState {}

class LiveTVLoadedState extends LiveTvState {
  final List<AllLiveTVChannels> channels;
  const LiveTVLoadedState({required this.channels});

  @override
  List<Object> get props => [channels];
}
