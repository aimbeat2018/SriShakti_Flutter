import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/password_reset_model.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../utils/edit_text_utils.dart';
import '../../utils/validators.dart';
import '../server/repository.dart';
import '../strings.dart';
import '../utils/loadingIndicator.dart';

class ResetPassword extends StatefulWidget {
  static final String route = '/ResetPassword';
  ResetPassword({Key? key}) : super(key: key);
  @override
  _ResetPasswordState createState() => new _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController resetPassEmailController = new TextEditingController();
  late bool isDark;
  bool isLoading = false;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_ResetPasswordState");
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: isDark ? CustomTheme.darkGrey : CustomTheme.primaryColor,
          title: Text(AppContent.resetPassword),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
          child: SingleChildScrollView(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(color: isDark ? CustomTheme.darkGrey : CustomTheme.primaryColor),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Image.asset('assets/logo.png', scale: 5),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: CustomTheme.boxShadow,
                            color: isDark ? CustomTheme.colorAccentDark : Colors.white,
                          ),
                          height: 310,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Text(
                                AppContent.resetPassword,
                                style: CustomTheme.authTitle,
                              ),
                              SizedBox(height: 25.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      EditTextUtils().getCustomEditTextField(
                                          hintValue: AppContent.emailAddress,
                                          keyboardType: TextInputType.emailAddress,
                                          controller: resetPassEmailController,
                                          style: isDark ? CustomTheme.authTitleGrey : CustomTheme.authTitle,
                                          underLineInputBorderColor: isDark ? CustomTheme.grey_transparent2 : CustomTheme.primaryColor,
                                          validator: (value) {
                                            return validateEmail(value);
                                          }),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              HelpMe().space(10),
                              ButtonTheme(
                                minWidth: 320.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: CustomTheme.darkGrey,
                                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      isLoading = true;
                                      PasswordResetModel? passwordResetModel = await Repository().passwordReset(userEmail: "mirmahfuz10@gmail.com");
                                      if (passwordResetModel != null) showShortToast(passwordResetModel.message!);
                                      isLoading = false;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                    child: Text(AppContent.send, style: TextStyle(color: Colors.white),),),
                                ),
                              ),
                              SizedBox(height: 8.0,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isLoading) Center(child: spinkit),
            ],
          )),
        ));
  }
}
