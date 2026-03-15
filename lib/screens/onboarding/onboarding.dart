import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  static const String routeName = 'onboarding';

  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Image.asset(
          theme.themeMode == ThemeMode.light
              ? 'assets/images/light_logo.png'
              : 'assets/images/dark_logo.png',
          width: 142,
          height: 27,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              Image.asset(
                theme.themeMode == ThemeMode.light
                    ? 'assets/images/light_being_creative.png'
                    : 'assets/images/dark_being_creative.png',
                width: 343,
                height: 343,
              ),
              Column(
                spacing: 16,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'onboardingTitle'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'onboardingSubtitle'.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'language'.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: context.locale == const Locale('ar', 'EG')
                            ? Theme.of(context).textButtonTheme.style
                            : Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          context.setLocale(const Locale('en', 'US'));
                        },
                        child: Text('english'.tr()),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: context.locale == const Locale('en', 'US')
                            ? Theme.of(context).textButtonTheme.style
                            : Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          context.setLocale(const Locale('ar', 'EG'));
                        },
                        child: Text('arabic'.tr()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'theme'.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: theme.themeMode == ThemeMode.light
                            ? Theme.of(context).elevatedButtonTheme.style
                            : Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          theme.changeTheme(ThemeMode.light);
                        },
                        child: ImageIcon(
                          AssetImage('assets/images/sun.png'),
                          size: 24.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: theme.themeMode == ThemeMode.dark
                            ? Theme.of(context).elevatedButtonTheme.style
                            : Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          theme.changeTheme(ThemeMode.dark);
                        },
                        child: ImageIcon(
                          AssetImage('assets/images/moon.png'),
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
                },
                child: Text(
                  'startText'.tr(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
