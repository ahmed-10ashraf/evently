import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/models/intro_model.dart';
import 'package:evently_details/providers/intro_provider.dart';
import 'package:evently_details/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding_screen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    final GlobalKey<IntroductionScreenState> introKey = GlobalKey<IntroductionScreenState>();

    return ChangeNotifierProvider(
      create: (context) => IntroProvider(),
      builder: (context, child) {
        IntroProvider intro = Provider.of<IntroProvider>(context);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Image.asset(
              theme.themeMode == ThemeMode.light
                  ? 'assets/images/light_logo.png'
                  : 'assets/images/dark_logo.png',
              width: 142,
              height: 27,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(Login.routeName);
                },
                child: Text(
                  'skip'.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                Expanded(
                  child: IntroductionScreen(
                    initialPage: intro.currentPageIndex,
                    key: introKey,
                    globalBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.surface,
                    onChange: (index) {
                      intro.changePage(index);
                    },
                    showNextButton: false,
                    showDoneButton: false,
                    showSkipButton: false,
                    dotsDecorator: DotsDecorator(
                      size: const Size.square(8.0),
                      activeSize: const Size(21.0, 8.0),
                      activeColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.onSurface,
                      spacing: const EdgeInsets.symmetric(horizontal: 6.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    pages: [
                      PageViewModel(
                        title: '',
                        body: '',
                        image: Image.asset(
                          theme.themeMode == ThemeMode.light
                              ? 'assets/images/light_hot_trending.png'
                              : 'assets/images/dark_hot_trending.png',
                          width: 343,
                          height: 343,
                        ),
                        decoration: PageDecoration(fullScreen: true),
                      ),
                      PageViewModel(
                        title: '',
                        body: '',
                        image: Image.asset(
                          theme.themeMode == ThemeMode.light
                              ? 'assets/images/light_planning.png'
                              : 'assets/images/dark_planning.png',
                          width: 343,
                          height: 343,
                        ),
                        decoration: PageDecoration(fullScreen: true),
                      ),
                      PageViewModel(
                        title: '',
                        body: '',
                        image: Image.asset(
                          theme.themeMode == ThemeMode.light
                              ? 'assets/images/light_share_moments.png'
                              : 'assets/images/dark_share_moments.png',
                          width: 343,
                          height: 343,
                        ),
                        decoration: PageDecoration(fullScreen: true),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      Text(
                        IntroModel.intros[intro.currentPageIndex].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        IntroModel.intros[intro.currentPageIndex].subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (intro.currentPageIndex == 2) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(Login.routeName);
                          } else {
                            intro.changePage(intro.currentPageIndex + 1);
                            introKey.currentState?.next();
                          }
                        },
                        child: intro.currentPageIndex == 2 ? Text('getStarted'.tr()) : Text('next'.tr()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
