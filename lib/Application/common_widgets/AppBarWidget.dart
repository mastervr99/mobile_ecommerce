import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_ecommerce/Application/components/AppSignIn.dart';
import 'package:mobile_ecommerce/Application/components/AppLanguageSelection.dart';
import 'package:flutter_translate/flutter_translate.dart';

PreferredSizeWidget appBarWidget(context) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: Image.asset(
      "assets/images/ic_app_icon.png",
      width: 80,
      height: 40,
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppSignIn()),
          );
        },
        icon: const Icon(FontAwesomeIcons.user),
        color: const Color(0xFF323232),
      ),
      IconButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => AppLanguageSelection());
        },
        icon: const Icon(FontAwesomeIcons.language),
        color: const Color(0xFF323232),
      ),
    ],
  );
}
