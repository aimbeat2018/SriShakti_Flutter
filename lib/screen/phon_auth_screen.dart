import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../bloc/auth/firebase_auth/firebase_auth_bloc.dart';
import '../../bloc/auth/firebase_auth/firebase_auth_event.dart';
import '../../bloc/auth/firebase_auth/firebase_auth_state.dart';
import '../../bloc/auth/phone_auth/phone_auth_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_state.dart';
import '../../models/user_model.dart';
import '../../screen/landing_screen.dart';
import '../../server/phone_auth_repository.dart';
import '../../service/authentication_service.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/otp_input.dart';
import '../../widgets/phone_number_input.dart';
import '../strings.dart';

late Bloc firebaseAuthBloc;

class PhoneAuthScreen extends StatefulWidget {
  static final String route = '/PhoneAuthScreen';
  final UserRepository? userRepository;

  const PhoneAuthScreen({Key? key, this.userRepository}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    printLog("_PhoneAuthScreenState");
    final authService = Provider.of<AuthService>(context);
    return BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
      listener: (context, state) {
        if (state is FirebaseAuthStateCompleted) {
          AuthUser? user = state.getUser;

          if (user == null) {
            firebaseAuthBloc.add(FirebaseAuthFailed);
          } else {
            //print('registration succeed');
            authService.updateUser(user);
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingScreen()),
                  (Route<dynamic> route) => false);
        }
      },
      child: BlocProvider<PhoneAuthBloc>(
        create: (context) => PhoneAuthBloc(userRepository: widget.userRepository!),
        child: Scaffold(
          body: Container(
              color: Colors.red,
              child: LoginForm()),
        ),
      ),
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  PhoneAuthBloc? _phonAuthBloc;
  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    isDark = appModeBox.get('isDark') ?? false;
    _phonAuthBloc = BlocProvider.of<PhoneAuthBloc>(context);
    firebaseAuthBloc = BlocProvider.of<FirebaseAuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      bloc: _phonAuthBloc,
      listener: (context, loginState) {
        if (loginState is ExceptionState || loginState is OtpExceptionState) {
          String? message;
          if (loginState is ExceptionState) {
            message = loginState.message;
          } else if (loginState is OtpExceptionState) {
            message = loginState.message;
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar( SnackBar(
               content: Text(message!),
               backgroundColor: Colors.red,
          ));

        }
      },
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppContent.phoneAuthTitle),
              backgroundColor:isDark!? CustomTheme.darkGrey:CustomTheme.primaryColor,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios)),
            ),
            body: Container(
              color:isDark!? CustomTheme.primaryColorDark:CustomTheme.whiteColor,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      Container(
                        child: getViewAsPerState(state),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  //renderViewsPerState
  getViewAsPerState(PhoneAuthState state) {
    if (state is OtpSentState || state is OtpExceptionState) {
      return OtpInput();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else if (state is LoginCompleteState) {
      User fbUser = state.getUser()!;
      print(fbUser.uid);
      print(fbUser.phoneNumber);
      firebaseAuthBloc.add(FirebaseAuthStarted());
      firebaseAuthBloc.add(FirebaseAuthCompleting(
        uid: fbUser.uid,
        phone: fbUser.phoneNumber,
        email: fbUser.email,
      ));
      return LoadingIndicator();
    } else {
      return NumberInput(isDark: isDark,);
    }
  }
}
