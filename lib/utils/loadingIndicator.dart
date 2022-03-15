import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../style/theme.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: spinkit,
    ),
  );
}
final spinkit = SpinKitCircle(
  color: CustomTheme.primaryColor,
  size: 50.0,
);