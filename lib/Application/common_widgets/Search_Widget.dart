import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/screens/Products_Search_Screen.dart';

class Search_Widget extends StatefulWidget {
  @override
  _Search_Widget_State createState() => _Search_Widget_State();
}

class _Search_Widget_State extends State<Search_Widget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Theme(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              prefixIcon: Icon(Icons.search),
              fillColor: Color(0xFFF2F4F5),
              hintStyle: TextStyle(color: Colors.grey[600]),
              hintText: translate("label_search_bar"),
            ),
            autofocus: false,
            onSubmitted: (value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Products_Search_Screen(searchTerms: value)),
            ),
          ),
          data: Theme.of(context).copyWith(
            primaryColor: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
