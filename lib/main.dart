import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/services/services/depency_services.dart';
import 'package:liqueur_brooze/services/services/hive_database.dart';
import 'package:liqueur_brooze/view/LoginScreen/login_screen.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/view/MainRouteScreen/main_route_screen.dart';
import 'package:liqueur_brooze/viewModel/add_category_provider.dart';
import 'package:liqueur_brooze/viewModel/add_page_provider.dart';
import 'package:liqueur_brooze/viewModel/add_sub_category_provider.dart';
import 'package:liqueur_brooze/viewModel/addcoupon_provider.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:liqueur_brooze/viewModel/dashboard_screen_provider.dart';
import 'package:liqueur_brooze/viewModel/router_provider.dart';
import 'package:liqueur_brooze/viewModel/shipping_charges_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// set dependency injection
  setupServiceLocator();

  /// initialize Hive data base
  await HiveDatabase.initializeHive();

  /// Set the status bar color globally
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.primaryColor, // Set the desired color
    statusBarIconBrightness: Brightness.light, // Light or dark icons
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => DashboardScreenProvider()),
    ChangeNotifierProvider(create: (context) => RouterProvider()),
    ChangeNotifierProvider(create: (context) => AddcouponProvider()),
    ChangeNotifierProvider(create: (context) => AddSubCategoryProvider()),
    ChangeNotifierProvider(create: (context) => AddCategoryProvider()),
    ChangeNotifierProvider(create: (context) => ShippingChargesProvider()),
    ChangeNotifierProvider(create: (context) => AddPageProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return MaterialApp(
        title: 'Liqueur Brooze Admin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
          Locale('fr', ''),
          Locale('de', ''),
        ],
        home: authProvider.isAuthenticated
            ? const MainRouteScreen()
            : const LoginScreen(),
      );
    });
  }
}
