import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LanguageSelectionComponent extends StatefulWidget {
  @override
  _LanguageSelectionComponentState createState() =>
      _LanguageSelectionComponentState();
}

class _LanguageSelectionComponentState
    extends State<LanguageSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(translate("label_language_selection")),
      actions: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                  child: Text("English"),
                  onPressed: () {
                    changeLocale(context, 'English');
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
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
                        backgroundColor: Color(0xFFAC252B),
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
