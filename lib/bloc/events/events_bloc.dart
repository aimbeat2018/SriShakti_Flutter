import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/events_model.dart';
import '../../server/repository.dart';

class ZamooEventsEvent {}

class GetZamooEventsEvent extends ZamooEventsEvent {
  final param;
  GetZamooEventsEvent({this.param});
}

class ZamooEventsState {}

class ZamooEventsInitailState extends ZamooEventsState {}

class ZamooEventsIsNotLoading extends ZamooEventsState {}

class ZamooEventsIsLoaded extends ZamooEventsState {
  List<EventsModel>? listEvents;
  ZamooEventsIsLoaded({this.listEvents});
}

class ZamooEventsErrorState extends ZamooEventsState {
  final error;
  ZamooEventsErrorState({this.error});
}

class ZamooEventsBloc extends Bloc<ZamooEventsEvent, ZamooEventsState?> {
  Repository repository;
  ZamooEventsBloc(this.repository) : super(null);

  ZamooEventsState get initialState => ZamooEventsInitailState();

  @override
  Stream<ZamooEventsState> mapEventToState(ZamooEventsEvent event) async* {
    if (event is GetZamooEventsEvent) {
      yield ZamooEventsInitailState();
      try {
        List<EventsModel>? listEvents = await repository.getEventsList();
        yield ZamooEventsIsLoaded(listEvents: listEvents);
      } catch (e) {
        yield ZamooEventsErrorState(error: e.toString());
      }
    }
  }
}
