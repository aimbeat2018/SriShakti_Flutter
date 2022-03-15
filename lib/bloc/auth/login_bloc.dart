import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  LoginBloc(this.repository) : super(LoginIsNotStartState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginCompletingFailed) {
      yield LoginCompletingFailedState();
    } else if (event is LoginCompleting) {
      AuthUser? userServerData = await repository.getLoginAuthUser(event.email, event.password);
      yield LoginCompletingStateCompleted(userServerData);
    } else if (event is LoginCompletingNotStarted) {
      yield LoginIsNotStartState();
    } else if (event is LoginCompletingStarted) {
      yield LoginCompletingStartedState();
    }
  }
}
