import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/screens/Home_Screen.dart';

class Language_Selection_Component extends StatefulWidget {
  @override
  _Language_Selection_Component_State createState() =>
      _Language_Selection_Component_State();
}

class _Language_Selection_Component_State
    extends State<Language_Selection_Component> {
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
                child: Text("Français"),
                onPressed: () {
                  changeLocale(context, 'French');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("English"),
                onPressed: () {
                  changeLocale(context, 'English');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("中国人"),
                onPressed: () {
                  changeLocale(context, 'Chinese');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("Español"),
                onPressed: () {
                  changeLocale(context, 'Spanish');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("Indonesia"),
                onPressed: () {
                  changeLocale(context, 'Indonesian');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("Português"),
                onPressed: () {
                  changeLocale(context, 'Portuguese');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("日本"),
                onPressed: () {
                  changeLocale(context, 'Japanese');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("Deutsch"),
                onPressed: () {
                  changeLocale(context, 'German');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                child: Text("हिन्दी"),
                onPressed: () {
                  changeLocale(context, 'Hindi');
                },
              ),
              InkWell(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Home_Screen();
                      },
                      transitionDuration: Duration(milliseconds: 200),
                    ),
                  );
                },
              )
            ]),
      ],
    );
  }
}
