import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phoneplus/auth/interfaces/providers/auth_provider.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/shared/interfaces/it/locators/logger_locator.dart';
import 'package:phoneplus/shared/interfaces/screens/buyer_welcome_screen.dart';
import 'package:phoneplus/shared/interfaces/screens/home_screen.dart';
import 'package:phoneplus/shared/interfaces/screens/seller_welcome_screen.dart';
import 'package:phoneplus/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:phoneplus/credits/interfaces/screens/new_plan_screen.dart';
import 'package:phoneplus/credits/interfaces/providers/credit_provider.dart';

void main() {
  setUpLoggerLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CreditProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.appTheme,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''),
          Locale('en', ''),
        ],
        home: StorageHelper.getToken() != null  ? (StorageHelper.getRole() == "Buyer" ? BuyerWelcomeScreen() : SellerWelcomeScreen()) :  const HomeScreen()
      ),
    );
  }
}
