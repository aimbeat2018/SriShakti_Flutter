import 'package:flutter/material.dart';
import '../../style/theme.dart';
class EditTextUtils {
  TextFormField getCustomEditTextField(
      {String hintValue = "",
        TextEditingController? controller,
         Widget? prefixWidget,
        Widget? suffixWidget ,
        TextStyle? style,
        Function? validator,
        bool obscureValue = false,
        int maxLines = 1,
        Color underLineInputBorderColor = CustomTheme.grey_transparent2,
      TextInputType? keyboardType}) {
    return  TextFormField(
      maxLines: maxLines,
      keyboardType:keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: underLineInputBorderColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: underLineInputBorderColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: underLineInputBorderColor),
        ),
        hintText: hintValue,
        hintStyle: style,
      ),
      style: style,
      validator: validator as String? Function(String?)?,
      obscureText: obscureValue,

    );
  }
}
