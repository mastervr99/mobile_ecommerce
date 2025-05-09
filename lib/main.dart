import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/screens/Home_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/Products_Search_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/Shopping_Cart_Screen.dart';
import 'package:mobile_ecommerce/Application/screens/User_Account_Screen.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:mobile_ecommerce/.env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'French',
      supportedLocales: [
        'English',
        'French',
        "Chinese",
        "Spanish",
        "Indonesian",
        "Portuguese",
        "Japanese",
        "German",
        "Hindi",
        "Italian"
      ],
      basePath: 'assets/app_languages/');
  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      // child: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(create: (context) => ShoppingCart())
      //   ],
      // ),
      child: MaterialApp(
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            fontFamily: 'Roboto',
            primaryColor: Colors.white,
            primaryColorDark: Colors.white,
            backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'MOBILE ESHOP'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: Drawer_Widget(),
        body: Home_Screen(),
      ),
    );
  }
}
