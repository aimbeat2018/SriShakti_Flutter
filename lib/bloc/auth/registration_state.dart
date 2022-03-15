import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

class RegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationIsNotStartState extends RegistrationState {
  @override
  List<Object?> get props => super.props;
}

class RegistrationStateCompleted extends RegistrationState {
  final user;
  RegistrationStateCompleted(this.user);
  AuthUser? get getUser => user;
  @override
  List<Object?> get props => [user];
}

class RegistrationFailedState extends RegistrationState {
  final loading = false;
  @override
  List<Object> get props => [loading];
}

class RegistrationStartedState extends RegistrationState {
  final loading = true;
  @override
  List<Object> get props => [loading];
}
