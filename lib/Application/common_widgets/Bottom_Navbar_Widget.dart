import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
      });

      switch (index) {
        case 0:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Home_Screen();
              },
              transitionDuration: Duration(milliseconds: 200),
            ),
          );
          break;
        case 1:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Products_Search_Screen();
              },
              transitionDuration: Duration(milliseconds: 200),
            ),
          );
          break;
        case 2:
          if (await check_if_user_connected()) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return User_Account_Screen();
                },
                transitionDuration: Duration(milliseconds: 200),
              ),
            );
          } else {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Sign_In_Component();
                },
                transitionDuration: Duration(milliseconds: 200),
              ),
            );
          }
          break;
        case 3:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Shopping_Cart_Screen();
              },
              transitionDuration: Duration(milliseconds: 200),
            ),
          );
          break;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: translate('label_home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: translate('label_search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: translate('label_account'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: translate('label_cart'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFAC252B),
      unselectedItemColor: Color(0xFFAC252B),
      onTap: _onItemTapped,
    );
  }
}
