import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/password_set_model.dart';
import '../../models/user_details_model.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../utils/edit_text_utils.dart';
import '../../utils/loadingIndicator.dart';
import '../../utils/profile_text_field.dart';
import '../../utils/validators.dart';
import '../../app.dart';
import '../../strings.dart';

class MyProfileScreen extends StatefulWidget {
  static final String route = '/MyProfileScreen';

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final deactivateFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController setPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController accountDeactivateReasonController =
      new TextEditingController();
  TextEditingController deleteController = new TextEditingController();
  ProfileDetailsModel? profileDetailsModel;
  SubmitResponseModel? _accountDeactivate;
  double? editTextWidth;
  late AuthService authService;
  bool isupdating = false;
  List<String> users = <String>['Male', 'Female'];
  String? selectedGender = 'Male';
  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');
  final picker = ImagePicker();
  File? _image;
  String? userId;

  //get Image Function
  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 120, maxWidth: 120);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  void initState() {
    isDark = appModeBox.get('isDark') ?? false;
    userId = AuthService().getUser()!.userId;
    fetchData();
    super.initState();
  }

  fetchData() async {
    profileDetailsModel = await Repository().userDetailsData(userID: userId);
    if (profileDetailsModel != null) {
      selectedGender = profileDetailsModel!.gender;
      fullNameController =
          TextEditingController(text: profileDetailsModel!.name);
      emailController = TextEditingController(text: profileDetailsModel!.email);
      phoneController = TextEditingController(text: profileDetailsModel!.phone);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    printLog("_MyProfileScreenState");
    authService = Provider.of<AuthService>(context);
    editTextWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _renderAppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color:
                isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
            child: profileDetailsModel != null
                ? SingleChildScrollView(
                    child: _renderProfileWidget(userId),
                  )
                : Center(
                    child: spinkit,
                  ),
          ),
          if (isupdating) spinkit,
        ],
      ),
    );
  }

  _renderAppBar() {
    return AppBar(
      title: Text(AppContent.myProfile),
      backgroundColor:
          isDark! ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
    );
  }

  _renderProfileWidget(String? userId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(75)),
                        child: _image == null
                            ? Image.network(
                                profileDetailsModel!.imageUrl!,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                _image!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            child: Icon(
                              Icons.edit,
                              color: CustomTheme.whiteColor,
                            ),
                            decoration: BoxDecoration(
                              color: CustomTheme.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          )),
                    ),
                  ],
                ),
                HelpMe().space(10.0),
                Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text(AppContent.fullName, style: CustomTheme.subText2)),

                ProfileTextField().getCustomEditTextField(
                  style: CustomTheme.bodyTextgray2,
                  hintValue: profileDetailsModel!.name,
                  controller: fullNameController,
                  validator: (value) {
                    return validateNotEmpty(value);
                  },
                ),
                HelpMe().space(20.0),

                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppContent.emailAddress,
                        style: CustomTheme.subText2)),

                ProfileTextField().getCustomEditTextField(
                  style: CustomTheme.bodyTextgray2,
                  hintValue:
                      profileDetailsModel!.email ?? profileDetailsModel!.email,
                  controller: emailController,
                  height: 50.0,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
                _space(20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppContent.phone, style: CustomTheme.subText2)),

                ProfileTextField().getCustomEditTextField(
                    controller: phoneController,
                    style: CustomTheme.bodyTextgray2,
                    hintValue: profileDetailsModel!.phone ??
                        AppContent.phonewithCountryCode,
                    validator: (value) {
                      return validateNotEmpty(value);
                    }),
                HelpMe().space(10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: new DropdownButton<String>(
                        value: selectedGender,
                        isExpanded: true,
                        underline: Container(
                          width: 0.0,
                          height: 0.0,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue;
                          });
                        },
                        items: users.map((user) {
                          return new DropdownMenuItem<String>(
                            value: user,
                            child: new Text(
                              user,
                              style: new TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                if (profileDetailsModel!.passwordAvailable!)
                  Container(
                    height: 35.0,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: AppContent.currentPassword,
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      style: CustomTheme.bodyTextgray2,
                      obscureText: true,
                    ),
                  ),
                _space(20),

                //set password
                if (!profileDetailsModel!.passwordAvailable!)
                  InkWell(
                      onTap: () async {
                        setPasswordDialog(userId, isDark);
                      },
                      child: HelpMe()
                          .submitButton(editTextWidth, AppContent.setPassword)),

                _space(20),
                //save changes button
                if (profileDetailsModel!.passwordAvailable!)
                  InkWell(
                      onTap: () async {
                        isupdating = true;
                        setState(() {});
                        if (_formKey.currentState!.validate()) {
                          String name = fullNameController.text;
                          String email = emailController.text.toString();
                          String? gender = selectedGender;
                          String password = passwordController.text.toString();
                          String phone = phoneController.text.toString();
                          ProfileDetailsModel model = ProfileDetailsModel(
                            name: name,
                            email: email,
                            gender: gender,
                            phone: phone,
                            userId: userId,
                          );
                          SubmitResponseModel? profileDetailsModel =
                              await Repository().userUpdateData(
                                  profileDetailsModel: model,
                                  password: password,
                                  image: _image);

                          if (profileDetailsModel != null) {
                            showShortToast(profileDetailsModel.data!);
                            isupdating = false;
                            setState(() {
                              profileDetailsModel = profileDetailsModel;
                            });
                          }
                        }
                      },
                      child: HelpMe()
                          .submitButton(editTextWidth, AppContent.saveChanges)),
                _space(50),
                Text(
                  AppContent.deactivateMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                _space(15),
                _renderAccountDeactiveWidget(editTextWidth, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _space(double space) {
    return SizedBox(height: space);
  }

  setPasswordDialog(String? userId, bool? isDark) async {
    //call current userId
    final User user = auth.currentUser!;
    final uid = user.uid;
    print(uid);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text("Set Passsword",
                  style: isDark!
                      ? CustomTheme.bodyText2White
                      : CustomTheme.bodyText2),
              backgroundColor: isDark ? CustomTheme.darkGrey : Colors.white,
              content: Container(
                height: 250.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: _passwordFormKey,
                      child: Column(
                        children: [
                          Container(
                            height: 35.0,
                            child: TextFormField(
                              controller: setPasswordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: CustomTheme.bodyTextgray2,
                              obscureText: true,
                            ),
                          ),
                          _space(30.0),
                          Container(
                            height: 35.0,
                            child: TextFormField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: CustomTheme.bodyTextgray2,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          if (_passwordFormKey.currentState!.validate()) {
                            String password = setPasswordController.text;
                            String confirmPassword =
                                confirmPasswordController.text;

                            print(password);
                            print(confirmPassword);
                            print(userId);

                            if (password == confirmPassword) {
                              SubmitResponseModel passwordSetModel =
                                  await (Repository().setUserPassword(
                                          userID: userId,
                                          password: password,
                                          firebaseAuthUid: uid)
                                      as FutureOr<SubmitResponseModel>);
                              showShortToast(passwordSetModel.data!);
                              setPasswordController.clear();
                              confirmPasswordController.clear();
                              Navigator.of(context).pop();
                            } else {
                              showShortToast("password don't match");
                            }
                          }
                        },
                        child: HelpMe().submitButton(
                            editTextWidth, AppContent.saveChanges))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _renderAccountDeactiveWidget(double? screnWidth, context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text(AppContent.deactivateAccount),
                content: accountDeactivateContent(),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                actionsPadding: EdgeInsets.only(right: 15.0),
                actions: <Widget>[
                  GestureDetector(
                      onTap: () {
                        if (deactivateFormKey.currentState!.validate())
                          accountDeactivate(context);
                      },
                      child: HelpMe().accountDeactivate(60, AppContent.yesText,
                          height: 30.0)),
                  GestureDetector(
                      onTap: () {
                        cancelDeactivateAccount(context);
                      },
                      child: HelpMe()
                          .submitButton(60, AppContent.noText, height: 30.0)),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text(AppContent.ifYouWontUseYourAccount, style: CustomTheme.bodyText1,),
              SizedBox(height: 10.0),
              HelpMe()
                  .accountDeactivate(screnWidth, AppContent.deactivateAccount),
            ],
          ),
        ),
      ),
    );
  }

  //render accountDeactivate
  Widget accountDeactivateContent() {
    return Container(
      child: Form(
        key: deactivateFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              AppContent.doYouWantToProceed,
              style: CustomTheme.authTitle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 40.0,
              child: EditTextUtils().getCustomEditTextField(
                  prefixWidget: Container(
                    width: 1.0,
                    height: 1.0,
                  ),
                  hintValue: AppContent.reasonText,
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  controller: accountDeactivateReasonController,
                  style: CustomTheme.coloredSubText,
                  validator: (value) {
                    return validateMinLength(value);
                  }),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 40.0,
              child: EditTextUtils().getCustomEditTextField(
                  hintValue: AppContent.deleteConfirm,
                  controller: deleteController,
                  prefixWidget: Container(
                    width: 5.0,
                    height: 5.0,
                  ),
                  style: CustomTheme.coloredBodyText2,
                  validator: (value) {
                    return validateDelete(value);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  //accountDeactivate Function
  accountDeactivate(context) async {
    _accountDeactivate = await Repository().accountDeactivate(
        userId: userId, reason: accountDeactivateReasonController.value.text);
    if (_accountDeactivate != null) {
      if (authService.getUser() != null) authService.deleteUser();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  //cancel account deactivate
  void cancelDeactivateAccount(context) {
    deleteController.clear();
    accountDeactivateReasonController.clear();
    Navigator.of(context).pop();
  }
}
