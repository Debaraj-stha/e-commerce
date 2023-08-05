import 'package:e_commerce/constraints/khalti.dart';
import 'package:e_commerce/controller/loginController.dart';
import 'package:e_commerce/pages/changeDeliveryAddressPage.dart';
import 'package:e_commerce/pages/homepage.dart';
import 'package:e_commerce/pages/loginPage.dart';
import 'package:e_commerce/pages/questionPage.dart';
import 'package:e_commerce/pages/welcomePage.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import 'pages/paymentPage.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => e_commerceProvider()),
        ],
        child: KhaltiScope(
          enabledDebugging: true,
            publicKey: constraint.publicKey,
            builder: (context, navKey) {
              return MaterialApp(
                  title: '',
                  debugShowCheckedModeBanner: false,
                  
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  navigatorKey: navKey,
                 localizationsDelegates: [KhaltiLocalizations.delegate],
                  home:homePage());
            }));
  }
}
