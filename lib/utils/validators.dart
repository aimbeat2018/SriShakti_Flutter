import 'package:fluttertoast/fluttertoast.dart';

String? validateNotEmpty(String value) {
  if (value.length == 0)
    return 'field is required!';
  else
    return null;
}

String? validateMinLength(String value, {int length = 6}) {
  if (value.length < length)
    return 'minimum $length character are required !';
  else
    return null;
}
String? validateMeetingCode(String value, {int length = 9}) {
  if (value.length != length)
    return 'Meeting code must be of $length digit !';
  else
    return null;
}

String? validatePhone(String value) {
  if (value.length < 10)
    return 'valid phone number is required !';
  else
    return null;
}

String? validateEmail(String value) {
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value))
    return 'valid email is required !';
  else
    return null;
}

String? validateDelete(String value) {
  if (value != "DELETE")
    return 'Please Type Delete';
  else
    return null;
}

void showShortToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1);
}
