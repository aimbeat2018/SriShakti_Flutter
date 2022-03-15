import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_bloc.dart';
import '../../bloc/auth/phone_auth/phone_auth_event.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../utils/edit_text_utils.dart';
import '../strings.dart';

// ignore: must_be_immutable
class NumberInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();
  String? _selectedCountryCode = AppContent.selectedCountryCode;
  final bool? isDark ;
  NumberInput({this.isDark});

  @override
  Widget build(BuildContext context) {
    double screnWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
      const EdgeInsets.only(top: 60, bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppContent.enterMobileNumber,
            style:isDark!?CustomTheme.bodyText2White:CustomTheme.authTitle,
          ),
          SizedBox(height: 50.0),
          Container(
            height: 32.0,
            child: Form(
              key: _formKey,
              child: EditTextUtils().getCustomEditTextField(
                  hintValue: AppContent.phonAuthHintValue,
                  controller: _phoneTextController,
                  prefixWidget: countryCde(),
                  style:isDark! ?CustomTheme.textFieldTitlePrimaryWhite :CustomTheme.textFieldTitlePrimaryColored,
                  keyboardType: TextInputType.number,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    /*print(_selectedCountryCode);*/
                    BlocProvider.of<PhoneAuthBloc>(context).add(SendOtpEvent(
                        phoNo: _selectedCountryCode! + _phoneTextController.value.text));
                  }
                },
                child: HelpMe().submitButton(screnWidth, AppContent.continueText)),
          ),
          Text(AppContent.byTappingContinue,style: isDark!? CustomTheme.bodyText2White:CustomTheme.coloredBodyText2,
          )
        ],
      ),
    );
  }

  Widget countryCde(){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 4.0),
      child: CountryCodePicker(
        textStyle:isDark!? CustomTheme.authTitleWhite: CustomTheme.authTitle,
        onChanged: (value){
          _selectedCountryCode = value.dialCode;
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: AppContent.initialCountrySelection,
        favorite: AppContent.favouriteCountryCode,
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
    );
  }
}