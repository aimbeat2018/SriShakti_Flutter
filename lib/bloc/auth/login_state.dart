import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginIsNotStartState extends LoginState {
  @override
  List<Object?> get props => super.props;
}

class LoginCompletingStateCompleted extends LoginState {
  final user;
  LoginCompletingStateCompleted(this.user);
  AuthUser? get getUser => user;
  @override
  List<Object?> get props => [user];
}

class LoginCompletingFailedState extends LoginState {
  final loading = false;
  @override
  List<Object> get props => [loading];
}

class LoginCompletingStartedState extends LoginState {
  final loading = true;
  @override
  List<Object> get props => [loading];
}
