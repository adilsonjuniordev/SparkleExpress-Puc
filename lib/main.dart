import 'package:sparkle_express/app/repositories/recibos_sheets_api.dart';
import 'package:sparkle_express/app/screens/home/home_bindings.dart';
import 'package:sparkle_express/app/screens/home/home_page.dart';
import 'package:sparkle_express/app/screens/login/login_bindings.dart';
import 'package:sparkle_express/app/screens/login/login_page.dart';
import 'package:sparkle_express/app/screens/newRegister/new_register_page.dart';
import 'package:sparkle_express/app/screens/newRegister/new_register_bindings.dart';
import 'package:sparkle_express/app/screens/registers/registers_bindings.dart';
import 'package:sparkle_express/app/screens/registers/registers_page.dart';
import 'package:sparkle_express/app/screens/splash/splash_bindings.dart';
import 'package:sparkle_express/app/screens/splash/splash_page.dart';
import 'package:sparkle_express/app/ui/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RecibosSheetsApi.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: MyTheme.principal,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const SplashPage(), binding: SplashBindings(), children: [
          GetPage(
            name: '/login',
            page: () => LoginPage(),
            binding: LoginBindings(),
          ),
          GetPage(
            name: '/home',
            page: () => const HomePage(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/newRegister',
            page: () => NewRegister(),
            binding: NewRegisterBindings(),
          ),
          GetPage(
            name: '/registers',
            page: () => const Registers(),
            binding: RegistersBindings(),
          ),
        ])
      ],
    );
  }
}
