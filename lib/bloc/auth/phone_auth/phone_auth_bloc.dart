import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oxoo/server/phone_auth_repository.dart';
import '../../../constants.dart';
import 'phone_auth_event.dart';
import 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final UserRepository _userRepository;
  // ignore: cancel_subscriptions
  StreamSubscription? subscription;
  String verID = "";

  PhoneAuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(InitialLoginState());

  @override
  Stream<PhoneAuthState> mapEventToState(
    PhoneAuthEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      subscription = sendOtp(event.phoNo!).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        UserCredential result = await _userRepository.verifyAndLogin(verID, event.otp!);
        if (result.user != null) {
          yield LoginCompleteState(result.user);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        printLog(e);
      }
    }
  }

  @override
  void onEvent(PhoneAuthEvent event) {
    super.onEvent(event);
    printLog(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    printLog(stacktrace);
  }

  Future<void> close() async {
    printLog("Bloc closed");
    super.close();
  }

  Stream<PhoneAuthEvent> sendOtp(String phoNo) async* {
    StreamController<PhoneAuthEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        printLog(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };
    final phoneVerificationFailed = (authException) {
      printLog(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, [int? forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _userRepository.sendOtp(
        phoNo, Duration(seconds: 1), phoneVerificationFailed, phoneVerificationCompleted, phoneCodeSent, phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
