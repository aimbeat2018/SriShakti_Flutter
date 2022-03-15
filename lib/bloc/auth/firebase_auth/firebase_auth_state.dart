import 'package:equatable/equatable.dart';
import 'package:oxoo/models/user_model.dart';

class FirebaseAuthState extends Equatable{
  @override
  List<Object?> get props => [];
}
class FirebaseAuthIsNotStartState extends FirebaseAuthState{
  @override
  List<Object?> get props => super.props;
}
class FirebaseAuthStateCompleted extends FirebaseAuthState{
  final user;
  FirebaseAuthStateCompleted(this.user);
  AuthUser? get getUser => user;
  @override
  List<Object?> get props => [user];
}
class FirebaseAuthFailedState extends FirebaseAuthState{
  final loading = false;
  @override
  List<Object> get props => [loading];
}
class FirebaseAuthStartedState extends FirebaseAuthState{
  final loading = true;
  @override
  List<Object> get props => [loading];
}