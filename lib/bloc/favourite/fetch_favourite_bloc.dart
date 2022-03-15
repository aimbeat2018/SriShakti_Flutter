import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/favourite_model.dart';
import '../../server/repository.dart';

class FetchFavouriteEvent {}

class GetFetchFavouriteEvent extends FetchFavouriteEvent {
  final param;
  GetFetchFavouriteEvent({this.param});
}

class FetchFavouriteState {}

class FetchFavouriteInitailState extends FetchFavouriteState {}

class FetchFavouriteIsNotLoading extends FetchFavouriteState {}

class FetchFavouriteIsLoaded extends FetchFavouriteState {
  FavouriteListModel? favouriteListModel;
  FetchFavouriteIsLoaded({this.favouriteListModel});
}

class FetchFavouriteErrorState extends FetchFavouriteState {
  final error;
  FetchFavouriteErrorState({this.error});
}

class FetchFavouriteBloc
    extends Bloc<FetchFavouriteEvent, FetchFavouriteState?> {
  Repository repository;
  FetchFavouriteBloc(this.repository) : super(null);

  FetchFavouriteState get initialState => FetchFavouriteInitailState();

  @override
  Stream<FetchFavouriteState> mapEventToState(
      FetchFavouriteEvent event) async* {
    if (event is GetFetchFavouriteEvent) {
      yield FetchFavouriteInitailState();
      try {
//        FavouriteListModel profileDetailsModel = await repository.favouriteData( userID: event.param);
//        yield FetchFavouriteIsLoaded(favouriteListModel: profileDetailsModel);
      } catch (e) {
        yield FetchFavouriteErrorState(error: e.toString());
      }
    }
  }
}
