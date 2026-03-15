import 'package:easy_localization/easy_localization.dart';

class IntroModel {
  String title;
  String subtitle;

  IntroModel({required this.title, required this.subtitle});

  static List<IntroModel> intros = [
    IntroModel(
      title: 'onboardingFindEventTitle'.tr(),
      subtitle: 'onboardingFindEventSubtitle'.tr(),
    ),
    IntroModel(
      title: 'onboardingPlanningEventTitle'.tr(),
      subtitle: 'onboardingPlanningEventSubtitle'.tr(),
    ),
    IntroModel(
      title: 'onboardingConnectTitle'.tr(),
      subtitle: 'onboardingConnectSubtitle'.tr(),
    ),
  ];
}
