import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/shared/interfaces/it/locators/logger_locator.dart';
import 'package:phoneplus/shared/interfaces/screens/buyer_welcome_screen.dart';
import 'package:phoneplus/shared/interfaces/screens/home_screen.dart';
import 'package:phoneplus/shared/interfaces/screens/seller_welcome_screen.dart';
import 'package:phoneplus/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import 'auth/interfaces/providers/auth_provider.dart';
import 'credits/interfaces/providers/credit_provider.dart';
import 'credits/interfaces/providers/bond_provider.dart';

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
        ChangeNotifierProvider(create: (_) => BondProvider()),
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
        home: FutureBuilder(
          future: _determineHomeScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data.'));
            }
            return snapshot.data!;
          },
        ),
      ),
    );
  }

  Future<Widget> _determineHomeScreen() async {
    String? token = await StorageHelper.getToken();
    String? role = await StorageHelper.getRole();
    print(role);
    if (token?.isNotEmpty ?? false) {
      if (role == "Inversionista") {
        return const BuyerWelcomeScreen();
      } else {
        return const SellerWelcomeScreen();
      }
    } else {
      return const HomeScreen();
    }
  }
}
