import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/CustomFormFieldValidator.dart';
import 'package:mobile_ecommerce/Application/MyHomePage.dart';
import 'package:mobile_ecommerce/Application/components/sign_up_component.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';

class SignInComponent extends StatefulWidget {
  @override
  _SignInComponentState createState() => _SignInComponentState();
}

signInSucceded(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Retrieve the text the that user has entered by using the
        // TextEditingController.
        content: Text(
          translate('label_sign_in_succeded'),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
              child: Text(translate('label_homepage')),
              onPressed: (() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'MOBILE ESHOP')),
                );
              }))
        ],
      );
    },
  );
}

emailNotRegistered(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Retrieve the text the that user has entered by using the
        // TextEditingController.
        content: Text(
          translate('label_email_not_registered'),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
              child: Text(translate('label_sign_up')),
              onPressed: (() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpComponent()),
                );
              }))
        ],
      );
    },
  );
}

signInEmailFailed(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          translate('label_sign_in_email_failed'),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

signInPasswordFailed(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          translate('label_sign_in_password_failed'),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

class _SignInComponentState extends State<SignInComponent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserRepository userRepository = UserRepositorySqfliteImpl();
  late SignInUsecase signInUsecase = SignInUsecase(userRepository);

  var formFieldValidator = CustomFormFieldValidator();
  bool _passwordhidden = true;

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white70,
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 130,
                          height: 130,
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/ic_app_icon.png"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: translate("label_email"),
                          ),
                          validator: (name) {
                            if (!formFieldValidator.isValidEmail(name)) {
                              return translate('label_valid_email');
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          showCursor: true,
                          obscureText: _passwordhidden,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordhidden = !_passwordhidden;
                                });
                              },
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: translate("label_password"),
                          ),
                          validator: (password) {
                            if (password == null) {
                              return translate('label_valid_password');
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            translate("label_password_forgotten"),
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(17.0),
                              primary: Color(0xFFBC1F26),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  side: BorderSide(color: Color(0xFFBC1F26))),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                User user = User();
                                user.setUserEmail(emailController.text);
                                user.setUserPassword(passwordController.text);

                                bool isEmailRegistered = await signInUsecase
                                    .checkIfEmailRegistered(user);

                                if (isEmailRegistered) {
                                  var isValidAccountPassword =
                                      await signInUsecase
                                          .checkIfValidAccountPassword(user);
                                  if (await isValidAccountPassword) {
                                    await signInUsecase.signIn(user);
                                    signInSucceded(context);
                                  } else {
                                    signInPasswordFailed(context);
                                  }
                                } else {
                                  signInEmailFailed(context);
                                }
                              }
                            },
                            child: Text(
                              translate("label_sign_in"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins-Medium.ttf',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              translate("label_new_account"),
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => {
                              Navigator.pop(context),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpComponent()),
                              )
                            },
                            child: Container(
                              child: Text(
                                translate("label_sign_up"),
                                style: TextStyle(
                                  color: Color(0xFFAC252B),
                                  fontFamily: defaultFontFamily,
                                  fontSize: defaultFontSize,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
