import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqueur_brooze/view/LoginScreen/login_screen.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/addcoupon_provider.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:liqueur_brooze/viewModel/dashboard_screen_provider.dart';
import 'package:liqueur_brooze/viewModel/router_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
