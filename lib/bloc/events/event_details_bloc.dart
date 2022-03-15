import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/events_details_model.dart';
import '../../server/repository.dart';

class ZamooEventDetailsEvent {}

class GetZamooEventDetailsEvent extends ZamooEventDetailsEvent {
  final eventId;
  final userId;
  GetZamooEventDetailsEvent({this.eventId, this.userId});
}

class ZamooEventDetailsState {}

class ZamooEventDetailsInitailState extends ZamooEventDetailsState {}

class ZamooEventDetailsIsNotLoading extends ZamooEventDetailsState {}

class ZamooEventDetailsIsLoaded extends ZamooEventDetailsState {
  EventDetailsModel? eventDetailsModel;
  ZamooEventDetailsIsLoaded({this.eventDetailsModel});
}

class ZamooEventDetailsErrorState extends ZamooEventDetailsState {
  final error;
  ZamooEventDetailsErrorState({this.error});
}

class ZamooEventDetailsBloc extends Bloc<ZamooEventDetailsEvent, ZamooEventDetailsState?> {
  Repository repository;
  ZamooEventDetailsBloc(this.repository) : super(null);

  ZamooEventDetailsState get initialState => ZamooEventDetailsInitailState();

  @override
  Stream<ZamooEventDetailsState> mapEventToState(
      ZamooEventDetailsEvent event) async* {
    if (event is GetZamooEventDetailsEvent) {
      yield ZamooEventDetailsInitailState();
      try {
        EventDetailsModel? listEvents = await repository.getEventDetails(
            eventId: event.eventId, userId: event.userId);
        yield ZamooEventDetailsIsLoaded(eventDetailsModel: listEvents);
      } catch (e) {
        yield ZamooEventDetailsErrorState(error: e.toString());
      }
    }
  }
}
