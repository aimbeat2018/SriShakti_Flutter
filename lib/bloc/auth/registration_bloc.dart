import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import '../../constants.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final Repository repository;
  RegistrationBloc(this.repository) : super(RegistrationIsNotStartState());

  RegistrationState get initialState => RegistrationIsNotStartState();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationFailed) {
      yield RegistrationFailedState();
    } else if (event is RegistrationCompleting) {
      final user = event.user;
      printLog(user);
      AuthUser? userServerData = await repository.getRegistrationAuthUser(
        name: user.name,
        email: user.email,
        password: event.password,
      );
      yield RegistrationStateCompleted(userServerData);
    } else if (event is RegistrationNotStarted) {
      yield RegistrationIsNotStartState();
    } else if (event is RegistrationStarted) {
      yield RegistrationStartedState();
    }
  }
}
