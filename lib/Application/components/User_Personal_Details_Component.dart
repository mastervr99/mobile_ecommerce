import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/Custom_Form_Field_Validator.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/usecases/update_user_details_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';

class User_Personal_Details_Component extends StatefulWidget {
  User connected_user;

  User_Personal_Details_Component({Key? key, required this.connected_user})
      : super(key: key);

  @override
  _User_Personal_Details_Component_State createState() =>
      _User_Personal_Details_Component_State();
}

registrationSucceded(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Retrieve the text the that user has entered by using the
        // TextEditingController.
        content: Text(
          translate('label_user_registration_succeded'),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

registrationFailed(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          translate('label_user_registration_failed'),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

UserRepository user_repository = UserRepositorySqfliteImpl();
Update_User_Details_Usecase update_user_details_usecase =
    Update_User_Details_Usecase(user_repository);

class _User_Personal_Details_Component_State
    extends State<User_Personal_Details_Component> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

  var formFieldValidator = Custom_Form_Field_Validator();

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
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
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: firstNameController,
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
                                  fillColor: Color(0xFFF2F3F5),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                  ),
                                  hintText: widget.connected_user
                                      .get_user_firstname(),
                                ),
                                validator: (name) {
                                  if (!formFieldValidator.isValidName(name)) {
                                    return translate('label_valid_firstname');
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: lastNameController,
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
                                  fillColor: Color(0xFFF2F3F5),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                  ),
                                  hintText:
                                      widget.connected_user.get_user_lastname(),
                                ),
                                validator: (name) {
                                  if (!formFieldValidator.isValidName(name)) {
                                    return translate('label_valid_lastname');
                                  }
                                },
                              ),
                            ),
                          ],
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
                            hintText: widget.connected_user.getUserEmail(),
                          ),
                          validator: (email) {
                            if (!formFieldValidator.isValidEmail(email)) {
                              return translate('label_valid_email');
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phone_number_controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
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
                              Icons.phone,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText:
                                widget.connected_user.get_user_phone_number(),
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
                                widget.connected_user
                                    .setUserEmail(emailController.text.trim());
                                widget.connected_user.set_user_phone_number(
                                    phone_number_controller.text.trim());
                                widget.connected_user.setUserFirstname(
                                    firstNameController.text.trim());
                                widget.connected_user.setUserLastname(
                                    lastNameController.text.trim());
                              }
                              bool is_unaffected_email =
                                  await update_user_details_usecase
                                      .check_if_new_email_available(
                                          widget.connected_user.getUserEmail());
                              if (await is_unaffected_email) {
                                await update_user_details_usecase.update(
                                  widget.connected_user,
                                );
                                registrationSucceded(context);
                              } else {
                                registrationFailed(context);
                              }
                            },
                            child: Text(
                              translate("label_register"),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
