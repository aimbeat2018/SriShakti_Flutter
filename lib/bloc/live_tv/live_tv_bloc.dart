import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/all_live_tv_by_category.dart';
import '../../server/repository.dart';

part 'live_tv_event.dart';
part 'live_tv_state.dart';

class LiveTvBloc extends Bloc<LiveTvEvent, LiveTvState> {
  final Repository repository;
  LiveTvBloc({required this.repository}) : super(LiveTvLoadingState());

  LiveTvState get initialState => LiveTvLoadingState();

  @override
  Stream<LiveTvState> mapEventToState(
    LiveTvEvent event,
  ) async* {
    if (event is FetchAllLiveTVData) {
      yield LiveTvLoadingState();
      try {
        final LiveTVListModel liveTVListModel = await (repository.getAllLiveTV() as FutureOr<LiveTVListModel>);
        yield LiveTVLoadedState(channels: liveTVListModel.channels);
      } catch (_) {
        yield LiveTvErrorState();
      }
    }
  }
}
