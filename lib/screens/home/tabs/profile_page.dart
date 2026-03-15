import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/providers/auth_provider.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [
              SizedBox(height: 16),
              Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    authProvider.userModel?.name ?? 'NA',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 4),
                  Text(
                    authProvider.userModel?.email ?? 'NA',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'darkMode'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Switch(
                      value: theme.themeMode == ThemeMode.dark,
                      onChanged: (onChnage) {
                        if (onChnage) {
                          theme.changeTheme(ThemeMode.dark);
                        } else {
                          theme.changeTheme(ThemeMode.light);
                        }
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (context.locale == const Locale('ar', 'EG')) {
                    context.setLocale(const Locale('en', 'US'));
                  } else {
                    context.setLocale(const Locale('ar', 'EG'));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'language'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseFunctions.logout();
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'logout'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Image.asset(
                        'assets/images/logout_logo.png',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
