import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/SearchWidget.dart';

class SearchBarResultsScreen extends StatefulWidget {
  @override
  _SearchBarResultsScreenState createState() => _SearchBarResultsScreenState();
}

class _SearchBarResultsScreenState extends State<SearchBarResultsScreen> {
  _SearchBarResultsScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Column(
        children: <Widget>[SearchWidget(), TestWidget(context)],
      ),
    );
  }
}

Widget TestWidget(BuildContext context) {
  final Future<String> _myNetworkData = Future<String>.delayed(
    const Duration(seconds: 4),
    () => 'This is what you have been waiting for',
  );

  return FutureBuilder(
      // future: searchedProducts,
      builder: (context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Center(child: Text('Check your internet connection!!'));
      case ConnectionState.waiting:
        return Center(child: Text('Loading ...'));
      default:
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        else
          return Text('Error: ${snapshot.error}');
    }
  });
}
