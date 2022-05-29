import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AppLanguageSelection extends StatefulWidget {
  @override
  _AppLanguageSelectionState createState() => _AppLanguageSelectionState();
}

class _AppLanguageSelectionState extends State<AppLanguageSelection> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(translate("label_language_selection")),
      actions: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  child: Text("English"),
                  onPressed: () {
                    changeLocale(context, 'English');
                  }),
              ElevatedButton(
                  child: Text("Français"),
                  onPressed: () {
                    changeLocale(context, 'French');
                  }),
              InkWell(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  })
            ]),
      ],
    );
  }
}
