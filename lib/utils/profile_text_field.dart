import 'package:flutter/material.dart';
class ProfileTextField {
  Widget getCustomEditTextField(
      {String? hintValue = "",
        double height = 50.0,
        TextEditingController? controller,
        TextStyle? style,
        Function? validator,
        bool obscureValue = false,
        int maxLines = 1,
        FocusNode? focusNode ,
        TextInputType? keyboardType}) {
    return Container(
      height: height,
      child: TextFormField(
        maxLines: maxLines,
        autofocus: false,
        keyboardType:keyboardType,
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.done,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hintValue,
          hintStyle: style,
        ),
        style: style,
        validator: validator as String? Function(String?)?,
        obscureText: obscureValue,
      ),
    );
  }
}
