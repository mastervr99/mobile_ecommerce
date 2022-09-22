import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/components/Address_Creation_Component.dart';
import 'package:mobile_ecommerce/Application/components/Address_Update_Component.dart';
import 'package:mobile_ecommerce/Application/screens/Orders_History_Screen.dart';
import 'package:mobile_ecommerce/Application/components/User_Personal_Details_Component.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/address_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_impl.dart';

class User_Account_Screen extends StatefulWidget {
  @override
  _User_Account_Screen_State createState() => _User_Account_Screen_State();
}

get_connected_user_data() async {
  ConnectedUserRepository connectedUserRepository =
      ConnectedUserRepositorySqfliteImpl();

  var connected_user = await connectedUserRepository.retrieveConnectedUser();

  UserRepository userRepository = UserRepositorySqfliteImpl();

  late var user;

  if (connected_user.runtimeType == User) {
    user = await userRepository
        .retrieve_user_by_id(await connected_user.get_user_id());
  }
  return await user;
}

get_user_addresses(User user) async {
  Address_Repository address_repository = Address_Repository_Sqflite_Impl();

  var addresses = await address_repository.retrieve_user_addresses(user);

  return await addresses;
}

class _User_Account_Screen_State extends State<User_Account_Screen> {
  String mobilenumber = '410-422-9171';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Icon ofericon = Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );

    Icon orders = Icon(
      Icons.shopping_bag,
      color: Colors.black38,
    );

    Icon menu = Icon(
      Icons.more_vert,
      color: Colors.black38,
    );
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;

    return Scaffold(
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
      body: FutureBuilder(
        future: get_connected_user_data(),
        builder: (context, AsyncSnapshot snapshot) {
          var connected_user = snapshot.data;

          if (snapshot.hasData) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(7.0),
                      alignment: Alignment.topCenter,
                      height: 260.0,
                      child: Card(
                        elevation: 3.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  margin: const EdgeInsets.all(10.0),
                                  // padding: const EdgeInsets.all(3.0),
                                  child: ClipOval(
                                    child:
                                        // Image.network(
                                        //     'https://www.fakenamegenerator.com/images/sil-female.png'),
                                        Image.asset(
                                      "assets/images/sil-male.png",
                                      // height: 250,
                                      // width: double.infinity,
                                    ),
                                  ),
                                )),

                            ElevatedButton(
                              onPressed: null,
                              child: Text(
                                translate("label_change"),
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.blueAccent),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.blueAccent)),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      top: 20.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        connected_user.get_user_firstname() +
                                            ' ' +
                                            connected_user.get_user_lastname(),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        mobilenumber,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        connected_user.getUserEmail(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    icon: ofericon,
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return User_Personal_Details_Component(
                                                connected_user: connected_user);
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 200),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            // VerticalDivider(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                      child: Text(
                        translate("label_addresses"),
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    Container(
                      height: 165.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            height: 165.0,
                            width: 56.0,
                            child: Card(
                              elevation: 3.0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return Address_Creation_Component(
                                                    connected_user:
                                                        connected_user);
                                              },
                                              transitionDuration:
                                                  Duration(milliseconds: 200),
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: get_user_addresses(connected_user),
                            builder: (context, AsyncSnapshot snapshot) {
                              var addresses_list = snapshot.data;

                              if (snapshot.hasData) {
                                return Container(
                                  height: 165.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: addresses_list.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 165.0,
                                        width: 230.0,
                                        margin: EdgeInsets.all(7.0),
                                        child: Card(
                                          elevation: 3.0,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 12.0,
                                                        top: 5.0,
                                                        right: 0.0,
                                                        bottom: 5.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          addresses_list[index]
                                                              .get_recipient_name(),
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                        _verticalDivider(),
                                                        Text(
                                                          addresses_list[index]
                                                                  .get_house_number() +
                                                              ' ' +
                                                              addresses_list[
                                                                      index]
                                                                  .get_street_name(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.5),
                                                        ),
                                                        _verticalDivider(),
                                                        Text(
                                                          addresses_list[index]
                                                                  .get_postal_code() +
                                                              ' ' +
                                                              addresses_list[
                                                                      index]
                                                                  .get_city(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.5),
                                                        ),
                                                        _verticalDivider(),
                                                        Text(
                                                          addresses_list[index]
                                                              .get_country(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.5),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                  icon: menu,
                                                  color: Colors.black38,
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) {
                                                          return Address_Update_Component(
                                                            address:
                                                                addresses_list[
                                                                    index],
                                                          );
                                                        },
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Circular_Progress_Widget();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 1.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Orders_History_Screen()),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              IconButton(onPressed: () {}, icon: orders),
                              _verticalD(),
                              Text(
                                translate("label_user_orders"),
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 1.0,
                        child: Row(
                          children: <Widget>[
                            IconButton(icon: keyloch, onPressed: null),
                            _verticalD(),
                            Text(
                              translate("label_password_change"),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Circular_Progress_Widget();
          }
        },
      ),
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
