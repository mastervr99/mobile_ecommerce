import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/CustomFormFieldValidator.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/usecases/add_an_address_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/update_user_details_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/address_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';

class Address_Creation_Component extends StatefulWidget {
  User connected_user;

  Address_Creation_Component({Key? key, required this.connected_user})
      : super(key: key);

  @override
  _Address_Creation_Component_State createState() =>
      _Address_Creation_Component_State();
}

registrationSucceded(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Retrieve the text the that user has entered by using the
        // TextEditingController.
        content: Text(
          translate('label_address_registration_succeded'),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

class _Address_Creation_Component_State
    extends State<Address_Creation_Component> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController recipient_name_controller = TextEditingController();
  TextEditingController house_number_ontroller = TextEditingController();
  TextEditingController street_name_controller = TextEditingController();
  TextEditingController postal_code_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();
  TextEditingController country_controller = TextEditingController();

  var formFieldValidator = CustomFormFieldValidator();

  @override
  Widget build(BuildContext context) {
    Address_Repository address_repository = Address_Repository_Sqflite_Impl();
    Add_An_Address_Usecase add_an_address_usecase =
        Add_An_Address_Usecase(address_repository);
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
                        TextFormField(
                          controller: recipient_name_controller,
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
                            hintText: translate("label_recipient_fullname"),
                          ),
                          validator: (recipient_fullname) {
                            if (!formFieldValidator
                                .isValidName(recipient_fullname)) {
                              return translate('label_valid_firstname');
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: house_number_ontroller,
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
                                  hintText: 'N°',
                                ),
                                validator: (house_number) {
                                  if (!formFieldValidator
                                      .check_if_valid_house_number(
                                          house_number)) {
                                    return translate('label_valid_firstname');
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                controller: street_name_controller,
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
                                  hintText: translate("label_street_name"),
                                ),
                                validator: (street_name) {
                                  if (!formFieldValidator
                                      .check_if_valid_street_name(
                                          street_name)) {
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
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: postal_code_controller,
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
                                  hintText: translate("label_postal_code"),
                                ),
                                validator: (postal_code) {
                                  if (!formFieldValidator
                                      .check_if_valid_postal_code(
                                          postal_code)) {
                                    return translate('label_valid_firstname');
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                controller: city_controller,
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
                                  hintText: translate("label_city_name"),
                                ),
                                validator: (city) {
                                  if (!formFieldValidator.isValidName(city)) {
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
                          controller: country_controller,
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
                                fontSize: defaultFontSize),
                            hintText: translate("label_country_name"),
                          ),
                          validator: (country) {
                            if (!formFieldValidator.isValidName(country)) {
                              return translate('label_valid_lastname');
                            }
                          },
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
                                Address address = Address();
                                address.set_user_id(
                                    widget.connected_user.get_user_id());
                                address.set_recipient_name(
                                    recipient_name_controller.text.trim());
                                address.set_house_number(
                                    house_number_ontroller.text.trim());
                                address.set_street_name(
                                    street_name_controller.text.trim());
                                address.set_postal_code(
                                    postal_code_controller.text.trim());
                                address.set_city(city_controller.text.trim());
                                address.set_country(
                                    country_controller.text.trim());

                                await add_an_address_usecase
                                    .register_user_address(address);
                                setState(() {});
                                registrationSucceded(context);
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
