import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneAuthState extends Equatable {}

class InitialLoginState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class OtpSentState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoginCompleteState extends PhoneAuthState {
  User? _firebaseUser;
  LoginCompleteState(this._firebaseUser);

  User? getUser() {
    return _firebaseUser;
  }

  @override
  List<Object?> get props => [_firebaseUser];
}

class ExceptionState extends PhoneAuthState {
  final String? message;
  ExceptionState({this.message});

  @override
  List<Object?> get props => [message];
}

class OtpExceptionState extends PhoneAuthState {
  final String? message;
  OtpExceptionState({this.message});

  @override
  List<Object?> get props => [message];
}
