import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:flutter/material.dart';

/// 有背景色button
Widget btnFlatButtonWidget({
  @required VoidCallback onPressed,
  double width = 240.0,
  double height = 48.0,
  Color bgColor = AppColor.primaryElement,
  String title = "button",
  Color fontColor = AppColor.primaryElementText,
  double fontSize = 18.0,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    width: cddSetWidth(width),
    height: cddSetHeight(height),
    child: FlatButton(
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: Radii.k10pxRadius,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontSize: cddSetFontSize(fontSize),
          height: 1,
        ),
      ),
    ),
  );
}

/// 纯文本button
Widget textBtnFlatButtonWidget({
  @required VoidCallback onPressed,
  @required String title,
  Color textColor = AppColor.primaryElement,
  double fontSize = 17,
}) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: cddSetFontSize(fontSize),
        color: textColor,
      ),
    ),
  );
}
