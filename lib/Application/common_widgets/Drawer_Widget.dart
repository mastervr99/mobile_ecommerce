import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/components/Language_Selection_Component.dart';
import 'package:mobile_ecommerce/Application/components/Sign_Up_Component.dart';
import 'package:mobile_ecommerce/Application/screens/User_Orders_Screen.dart';
import 'package:mobile_ecommerce/main.dart';
import 'package:mobile_ecommerce/Application/components/Sign_In_Component.dart';

class Drawer_Widget extends StatefulWidget {
  @override
  _Drawer_Widget_State createState() => _Drawer_Widget_State();
}

class _Drawer_Widget_State extends State<Drawer_Widget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),
            _createDrawerItem(
                icon: Icons.home,
                text: translate('label_home'),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'ESHOP')),
                    )),
            _createDrawerItem(
                icon: Icons.call,
                text: translate('label_contact'),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              /**EmptyWishListScreen()*/ Sign_In_Component()),
                    )),
            _createDrawerItem(
              icon: Icons.language,
              text: translate('SELECT LANGUAGE'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Language_Selection_Component()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.login,
              text: translate('SIGN IN'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sign_In_Component()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.app_registration,
              text: translate('SIGN UP'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sign_Up_Component()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.app_registration,
              text: translate('SIGN UP'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sign_Up_Component()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.shopping_bag_outlined,
              text: translate('MY ORDERS'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User_Orders_Screen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Image.asset(
            'assets/images/ic_app_icon.png',
            width: 130,
            height: 130,
          ),
        ),
      ),
    ]),
  );
}

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Color(0xFF808080),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(color: Color(0xFF484848)),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
