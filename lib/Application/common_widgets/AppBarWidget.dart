import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_ecommerce/Application/components/sign_in_component.dart';
import 'package:mobile_ecommerce/Application/components/language_selection_component.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';

PreferredSizeWidget appBarWidget(context) {
  return AppBar(
    backgroundColor: Color(0xFFAC252B),
    elevation: 0.0,
    centerTitle: true,
    title: Image.asset(
      "assets/images/ic_app_icon.png",
      width: 80,
      height: 40,
    ),
    actions: <Widget>[
      // IconButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => SignInComponent()),
      //     );
      //   },
      //   icon: const Icon(FontAwesomeIcons.user),
      //   color: const Color(0xFF323232),
      // ),
      displayAccountOrConnectionIcon(context),
      IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => LanguageSelectionComponent());
        },
        icon: const Icon(FontAwesomeIcons.language),
        color: const Color(0xFF323232),
      ),
    ],
  );
}

Widget displayAccountOrConnectionIcon(BuildContext context) {
  return FutureBuilder(
    future: checkIfUserConnected(),
    builder: (context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
        default:
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else if (snapshot.data == true)
            return IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.userNinja),
                color: const Color(0xFF323232));
          else
            return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInComponent()),
                  );
                },
                icon: const Icon(FontAwesomeIcons.user),
                color: const Color(0xFF323232));
      }
    },
  );
}

checkIfUserConnected() async {
  UserRepository userRepository = UserRepositorySqfliteImpl();
  ConnectedUserRepository connectedUserRepository =
      ConnectedUserRepositorySqfliteImpl();
  SignInUsecase signInUsecase =
      SignInUsecase(userRepository, connectedUserRepository);

  return await signInUsecase.checkIfUserConnected();
}
