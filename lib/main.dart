import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/firebase_options.dart';
import 'package:online_electronic_shopping_app/service/auth/auth_gate.dart';
import 'package:online_electronic_shopping_app/service/auth/auth_service.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:online_electronic_shopping_app/service/userActivity/favourite.activity.dart';
import 'package:online_electronic_shopping_app/service/userActivity/get_data.dart';
import 'package:online_electronic_shopping_app/service/userinfo/user_info.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserInfo(),
      ),
      ChangeNotifierProvider(
        create: (context) => GetData(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavouriteLogic(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartLogic(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
