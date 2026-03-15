import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/app_theme.dart';
import 'package:evently_details/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/add_event/add_event.dart';
import 'screens/authentication/forget_password.dart';
import 'screens/authentication/login.dart';
import 'screens/authentication/register.dart';
import 'screens/details/details.dart';
import 'screens/edit/edit.dart';
import 'screens/home/home.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await EasyLocalization.ensureInitialized();
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: authProvider.user != null ? Home.routeName : Onboarding.routeName,
      routes: {
        Onboarding.routeName: (context) =>  Onboarding(),
        OnboardingScreen.routeName: (context) =>  OnboardingScreen(),
        Login.routeName: (context) =>  Login(),
        Register.routeName: (context) =>  Register(),
        ForgetPassword.routeName: (context) =>  ForgetPassword(),
        Home.routeName: (context) => Home(),
        AddEvent.routeName: (context) => AddEvent(),
        Details.routeName: (context) => Details(),
        Edit.routeName: (context) => Edit(),
      },
    );
  }
}
