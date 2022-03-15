import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SendOtpEvent extends PhoneAuthEvent {
  String? phoNo;
  SendOtpEvent({this.phoNo});
}

class AppStartEvent extends PhoneAuthEvent {}

// ignore: must_be_immutable
class VerifyOtpEvent extends PhoneAuthEvent {
  String? otp;
  VerifyOtpEvent({this.otp});
}

class LogoutEvent extends PhoneAuthEvent {}

class OtpSendEvent extends PhoneAuthEvent {}

class LoginCompleteEvent extends PhoneAuthEvent {
  final User? firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

// ignore: must_be_immutable
class LoginExceptionEvent extends PhoneAuthEvent {
  String message;
  LoginExceptionEvent(this.message);
}
