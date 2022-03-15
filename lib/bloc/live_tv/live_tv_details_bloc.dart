import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/live_tv_details_model.dart';
import '../../server/repository.dart';

class LiveTvDetailsEvent {}

class GetLiveTvDetailsEvent extends LiveTvDetailsEvent {
  final liveTvId;
  final userId;
  GetLiveTvDetailsEvent({this.liveTvId, this.userId});
}

class LiveTvDetailsState {}

class LiveTvDetailsInitailState extends LiveTvDetailsState {}

class LiveTvDetailsIsNotLoading extends LiveTvDetailsState {}

class LiveTvDetailsIsLoaded extends LiveTvDetailsState {
  LiveTvDetailsModel? liveTvDetailsModel;
  LiveTvDetailsIsLoaded({this.liveTvDetailsModel});
}

class LiveTvDetailsErrorState extends LiveTvDetailsState {
  final error;
  LiveTvDetailsErrorState({this.error});
}

class LiveTvDetailsBloc extends Bloc<LiveTvDetailsEvent, LiveTvDetailsState> {
  Repository repository;
  LiveTvDetailsBloc(this.repository) : super(LiveTvDetailsInitailState());

  LiveTvDetailsState get initialState => LiveTvDetailsInitailState();

  @override
  Stream<LiveTvDetailsState> mapEventToState(LiveTvDetailsEvent event) async* {
    if (event is GetLiveTvDetailsEvent) {
      yield LiveTvDetailsInitailState();
      try {
        LiveTvDetailsModel? liveTvDetailsModel =
            await repository.getLiveTVDetailsData(
                liveTvId: event.liveTvId, userId: event.userId);
        yield LiveTvDetailsIsLoaded(liveTvDetailsModel: liveTvDetailsModel);
      } catch (e) {
        yield LiveTvDetailsErrorState(error: e.toString());
      }
    }
  }
}
