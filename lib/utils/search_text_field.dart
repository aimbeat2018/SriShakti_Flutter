import 'package:flutter/material.dart';
class SearchTextField {
  TextFormField getCustomEditTextField(
      {String hintValue = "",
        TextEditingController? controller,
        TextStyle? style,
        Function? validator,
        bool obscureValue = false,
        int maxLines = 1,
        FocusNode? focusNode ,
        Function? onFieldSubmitted,
      TextInputType? keyboardType}) {
    return  TextFormField(
      maxLines: maxLines,
      style: style,
      onFieldSubmitted: onFieldSubmitted as void Function(String)?,
      autofocus: false,
      keyboardType:keyboardType,
      controller: controller,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: const Icon(Icons.search,color: Colors.white,),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintValue,
        hintStyle: style,
      ),
      validator: validator as String? Function(String?)?,
      obscureText: obscureValue,

    );
  }
}
