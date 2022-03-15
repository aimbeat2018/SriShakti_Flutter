import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_details_model.dart';
import '../../server/repository.dart';

class ProfileDetailsEvent {}

class GetProfileDetailsEvent extends ProfileDetailsEvent {
  final userId;
  GetProfileDetailsEvent({this.userId});
}

class ProfileDetailsState {}

class ProfileDetailsInitailState extends ProfileDetailsState {}

class ProfileDetailsIsNotLoading extends ProfileDetailsState {}

class ProfileDetailsIsLoaded extends ProfileDetailsState {
  ProfileDetailsModel? profileDetailsModel;
  ProfileDetailsIsLoaded({this.profileDetailsModel});
}

class ProfileDetailsErrorState extends ProfileDetailsState {
  final error;
  ProfileDetailsErrorState({this.error});
}

class ProfileDetailsBloc
    extends Bloc<ProfileDetailsEvent, ProfileDetailsState?> {
  Repository repository;
  ProfileDetailsBloc(this.repository) : super(null);

  ProfileDetailsState get initialState => ProfileDetailsInitailState();

  @override
  Stream<ProfileDetailsState> mapEventToState(
      ProfileDetailsEvent event) async* {
    if (event is GetProfileDetailsEvent) {
      yield ProfileDetailsInitailState();
      try {
        ProfileDetailsModel? profileDetailsModel =
            await repository.userDetailsData(userID: event.userId);
        yield ProfileDetailsIsLoaded(profileDetailsModel: profileDetailsModel);
      } catch (e) {
        yield ProfileDetailsErrorState(error: e.toString());
      }
    }
  }
}
