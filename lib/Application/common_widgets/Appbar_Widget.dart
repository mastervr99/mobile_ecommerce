import 'package:flutter/material.dart';

PreferredSizeWidget Appbar_Widget(context) {
  return AppBar(
    backgroundColor: Color(0xFFAC252B),
    elevation: 0.0,
    centerTitle: true,
    title: Image.asset(
      "assets/images/ic_app_icon.png",
      width: 80,
      height: 40,
    ),
    leading: (ModalRoute.of(context)?.canPop ?? false) ? BackButton() : null,
  );
}
