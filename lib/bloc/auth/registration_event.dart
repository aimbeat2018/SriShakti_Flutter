import 'package:equatable/equatable.dart';

class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationCompleting extends RegistrationEvent {
  final user;
  final password;
  RegistrationCompleting({required this.user, required this.password});
  @override
  List<Object> get props => [user, password];
}

class RegistrationFailed extends RegistrationEvent {
  @override
  List<Object> get props => super.props;
}

class RegistrationNotStarted extends RegistrationEvent {
  @override
  List<Object> get props => super.props;
}

class RegistrationStarted extends RegistrationEvent {
  @override
  List<Object> get props => super.props;
}
