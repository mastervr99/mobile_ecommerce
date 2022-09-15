import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/components/Sign_In_Component.dart';
import 'package:mobile_ecommerce/Application/screens/Home_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/Products_Search_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/Shopping_Cart_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/User_Account_Screen.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/main.dart';

class Bottom_Navbar_Widget extends StatefulWidget {
  @override
  _Bottom_Navbar_Widget_State createState() => _Bottom_Navbar_Widget_State();
}

check_if_user_connected() async {
  ConnectedUserRepository connectedUserRepository =
      ConnectedUserRepositorySqfliteImpl();
  UserRepository userRepository = UserRepositorySqfliteImpl();

  SignInUsecase signInUsecase =
      SignInUsecase(userRepository, connectedUserRepository);

  return await signInUsecase.checkIfUserConnected();
}

class _Bottom_Navbar_Widget_State extends State<Bottom_Navbar_Widget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) async {
      setState(() {
        _selectedIndex = index;
        navigateToScreens(index);
      });

      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home_Screen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Products_Search_Screen()),
          );
          break;
        case 2:
          if (await check_if_user_connected()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => User_Account_Screen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Sign_In_Component()),
            );
          }
          break;
        case 3:
          Navigator.pushReplacement(
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
