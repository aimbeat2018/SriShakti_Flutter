import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../bloc/auth/registration_bloc.dart';
import '../../bloc/auth/registration_event.dart';
import '../../bloc/auth/registration_state.dart';
import '../../models/user_model.dart';
import '../../screen/landing_screen.dart';
import '../../service/authentication_service.dart';
import '../../style/theme.dart';
import '../../utils/edit_text_utils.dart';
import '../../utils/validators.dart';
import '../../strings.dart';

class SignUpScreen extends StatefulWidget {
  static final String route = '/SignUpScreen';
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() {
    // TODO: implement createState
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _signUpFormkey = GlobalKey<FormState>();
  TextEditingController loginNameController = new TextEditingController();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  late bool _isRegistered;
  late Bloc bloc;
  Bloc? firebaseAuthBloc;
  bool isMandatoryLogin = false;
  bool isLoading = false;
  late bool isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RegistrationBloc>(context);
    isDark = appModeBox.get('isDark') ?? false;
    isDark = false;
    _isRegistered = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_SignUpScreenState");
    final authService = Provider.of<AuthService>(context);

    ///read user data from phone(flutter hive box)
    _isRegistered = authService.getUser() != null ? true : false;
    return new Scaffold(
      key: _scaffoldKey,
      body: _isRegistered ? LandingScreen() : _renderRegisterWidget(authService),
    );
  }

  Widget _renderRegisterWidget(authService) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationStateCompleted) {
          isLoading = false;
          AuthUser? user = state.getUser;
          if (user == null) {
            //print("user is null");
            bloc.add(RegistrationFailed());
          } else {
            authService.updateUser(user);
          }
          if (authService.getUser() != null) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingScreen()), (Route<dynamic> route) => false);
          }
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.0,
              backgroundColor: isDark ? CustomTheme.darkGrey : CustomTheme.primaryColor,
              title: Text(AppContent.backToLogin),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(
                          /* gradient: new LinearGradient(
                                  colors: [
                                    isDark? CustomTheme.darkGrey:CustomTheme.primaryColor,
                                    isDark? CustomTheme.darkGrey:CustomTheme.colorAccent,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),*/
                          color: isDark ? CustomTheme.darkGrey : CustomTheme.primaryColor,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Image.asset('assets/logo.png', scale: 5),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 23.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: CustomTheme.boxShadow,
                                    color: isDark ? CustomTheme.colorAccentDark : Colors.white,
                                  ),
                                  height: 340.0,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      Text(
                                        AppContent.signup,
                                        style: CustomTheme.authTitle,
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: Form(
                                          key: _signUpFormkey,
                                          child: Column(
                                            children: <Widget>[
                                              EditTextUtils().getCustomEditTextField(
                                                  hintValue: AppContent.fullName,
                                                  keyboardType: TextInputType.text,
                                                  controller: loginNameController,
                                                  style: isDark ? CustomTheme.authTitleGrey : CustomTheme.authTitle,
                                                  underLineInputBorderColor: isDark ? CustomTheme.grey_transparent2 : CustomTheme.primaryColor,
                                                  validator: (value) {
                                                    return validateNotEmpty(value);
                                                  }),
                                              SizedBox(height: 10),
                                              EditTextUtils().getCustomEditTextField(
                                                  hintValue: AppContent.emailAddress,
                                                  keyboardType: TextInputType.emailAddress,
                                                  style: isDark ? CustomTheme.authTitleGrey : CustomTheme.authTitle,
                                                  underLineInputBorderColor: isDark ? CustomTheme.grey_transparent2 : CustomTheme.primaryColor,
                                                  controller: loginEmailController,
                                                  validator: (value) {
                                                    return validateEmail(value);
                                                  }),
                                              SizedBox(height: 10),
                                              EditTextUtils().getCustomEditTextField(
                                                  hintValue: AppContent.password,
                                                  keyboardType: TextInputType.text,
                                                  style: isDark ? CustomTheme.authTitleGrey : CustomTheme.authTitle,
                                                  underLineInputBorderColor: isDark ? CustomTheme.grey_transparent2 : CustomTheme.primaryColor,
                                                  controller: loginPasswordController,
                                                  obscureValue: true,
                                                  validator: (value) {
                                                    return validateMinLength(value);
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: CustomTheme.primaryColor,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),),
                                          onPressed: () {
                                            if (_signUpFormkey.currentState!.validate()) {
                                              isLoading = true;
                                              AuthUser user = AuthUser(name: loginNameController.text, email: loginEmailController.text);
                                              // Registration started bloc
                                              bloc.add(RegistrationStarted());
                                              bloc.add(RegistrationCompleting(user: user, password: loginPasswordController.text));
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 15.0,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  AppContent.register,
                                                  style: CustomTheme.authTitleWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
