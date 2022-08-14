import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/BottomNavBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/CustomDrawerWidget.dart';
import 'package:mobile_ecommerce/Application/screens/HomeScreen.dart';
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
      supportedLocales: ['English', 'French'],
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
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ShoppingCart())
          ],
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
        ));
  }
}

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> viewContainer = [
    HomeScreen(),
    //WishListScreen(),
    //ShoppingCartScreen(),
    //HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        endDrawer: CustomDrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
