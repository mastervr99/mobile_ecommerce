import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_ecommerce/Application/components/AppSignIn.dart';
import 'package:flutter_translate/flutter_translate.dart';

PreferredSizeWidget appBarWidget(context) {
  showMyAlertDialog(BuildContext context) {
    // Create AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text("Sélection langage"),
      actions: [
        ElevatedButton(
            child: Text("English"),
            onPressed: () {
              changeLocale(context, 'English');
              Navigator.of(context).pop(); // Return true
            }),
        ElevatedButton(
            child: Text("French"),
            onPressed: () {
              changeLocale(context, 'French');
              Navigator.of(context).pop(); // Return false
            })
      ],
    );
  }

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
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(translate("label_language_selection")),
                  actions: [
                    ElevatedButton(
                        child: Text("English"),
                        onPressed: () {
                          changeLocale(context, 'English');
                          Navigator.of(context).pop();
                        }),
                    ElevatedButton(
                        child: Text("Français"),
                        onPressed: () {
                          changeLocale(context, 'French');
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        },
        icon: const Icon(FontAwesomeIcons.language),
        color: const Color(0xFF323232),
      ),
    ],
  );
}
