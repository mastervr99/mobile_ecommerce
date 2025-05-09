import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/components/Language_Selection_Component.dart';
import 'package:mobile_ecommerce/Application/components/Sign_Up_Component.dart';
import 'package:mobile_ecommerce/Application/screens/Home_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/Orders_History_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/User_Account_Screen.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_out_usecase.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Application/components/Sign_In_Component.dart';

class Drawer_Widget extends StatefulWidget {
  @override
  _Drawer_Widget_State createState() => _Drawer_Widget_State();
}

class _Drawer_Widget_State extends State<Drawer_Widget> {
  ConnectedUserRepository connectedUserRepository =
      ConnectedUserRepositorySqfliteImpl();

  check_if_user_connected() async {
    UserRepository userRepository = UserRepositorySqfliteImpl();
    SignInUsecase signInUsecase =
        SignInUsecase(userRepository, connectedUserRepository);

    return await signInUsecase.checkIfUserConnected();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: FutureBuilder(
        future: check_if_user_connected(),
        builder: (context, AsyncSnapshot snapshot) {
          var is_user_connected = snapshot.data;

          if (snapshot.hasData) {
            if (is_user_connected == true) {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _createDrawerHeader(),
                    _createDrawerItem(
                      icon: Icons.home,
                      text: translate('label_home'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home_Screen()),
                      ),
                    ),
                    _createDrawerItem(
                      icon: Icons.shopping_bag_outlined,
                      text: translate('label_personal_account'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User_Account_Screen()),
                      ),
                    ),
                    _createDrawerItem(
                      icon: Icons.shopping_bag_outlined,
                      text: translate('label_personal_orders'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Orders_History_Screen()),
                      ),
                    ),
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
                      text: translate('label_language_selection'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Language_Selection_Component()),
                      ),
                    ),
                    _createDrawerItem(
                      icon: Icons.logout,
                      text: translate('label_sign_out'),
                      onTap: () async {
                        SignOutUsecase signOutUsecase =
                            SignOutUsecase(connectedUserRepository);
                        await signOutUsecase.disconnectUser();

                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return Home_Screen();
                            },
                            transitionDuration: Duration(milliseconds: 200),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _createDrawerHeader(),
                    _createDrawerItem(
                      icon: Icons.home,
                      text: translate('label_home'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home_Screen()),
                      ),
                    ),
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
                      text: translate('label_language_selection'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Language_Selection_Component()),
                      ),
                    ),
                    _createDrawerItem(
                      icon: Icons.login,
                      text: translate('label_sign_in'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sign_In_Component()),
                      ),
                    ),
                    _createDrawerItem(
                      icon: Icons.app_registration,
                      text: translate('label_sign_up'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sign_Up_Component()),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Circular_Progress_Widget();
          }
        },
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
