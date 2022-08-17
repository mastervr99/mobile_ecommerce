import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/screens/Products_Search_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/Shopping_Cart_Screen.dart';
import 'package:mobile_ecommerce/main.dart';

class Bottom_Navbar_Widget extends StatefulWidget {
  @override
  _Bottom_Navbar_Widget_State createState() => _Bottom_Navbar_Widget_State();
}

class _Bottom_Navbar_Widget_State extends State<Bottom_Navbar_Widget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        navigateToScreens(index);
      });

      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: 'ESHOP')),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Products_Search_Screen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Products_Search_Screen()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Shopping_Cart_Screen()),
          );
          break;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFAA292E),
      unselectedItemColor: Color(0xFF545454),
      onTap: _onItemTapped,
    );
  }
}
