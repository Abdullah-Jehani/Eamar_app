import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/screens/auth/splash_screen.dart';
import 'package:eamar_app/screens/boarding/board_screen_one.dart';
import 'package:eamar_app/screens/secondary/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ReportProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    const TabsScreen();
    Provider.of<AuthProvider>(context, listen: false).initAuthentication();
    Provider.of<AuthProvider>(context, listen: false).checkFirstTime();
    Provider.of<AuthProvider>(context, listen: false).loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return auth.isLoading == null
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : auth.isFirstTime
              ? const BoardScreenOne()
              : auth.isAuthenticated!
                  ? const TabsScreen()
                  : const LoginScreen();
    });
  }
}
