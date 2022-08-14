import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/CustomDrawerWidget.dart';
import 'package:mobile_ecommerce/Application/screens/HomeScreen.dart';

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> viewContainer = [
    HomeScreen(),
    //WishListScreen(),
    //ShoppingCartScreen(),
    //HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        drawer: CustomDrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        //bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
