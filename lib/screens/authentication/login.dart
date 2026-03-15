import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/providers/auth_provider.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/authentication/forget_password.dart';
import 'package:evently_details/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register.dart';
import 'widgets/evently_textfield.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'loginTitle'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    EventlyTextfield(
                      hint: 'userEmail'.tr(),
                      email: true,
                      controller: emailController,
                      validation: 'Invalid Email',
                      prefixIcon: 'mail.png',
                    ),
                    const SizedBox(height: 16),
                    EventlyTextfield(
                      hint: 'userPassword'.tr(),
                      password: true,
                      controller: passwordController,
                      validation: 'Password Should Contain Special Characters',
                      prefixIcon: 'lock.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(ForgetPassword.routeName, arguments: emailController.text);
                  },
                  child: Text('forgetPassword'.tr()),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var user = FirebaseFunctions.login(
                      emailController.text,
                      passwordController.text,
                    );
                    authProvider.initUser();
                    if (user != null) {
                      Navigator.of(context).pushReplacementNamed(
                          Home.routeName);
                    }
                  }
                },
                child: Text(
                  'login'.tr(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'signUpText'.tr(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(Register.routeName);
                    },
                    child: Text('signUp'.tr()),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'or'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () async {
                  final user = await FirebaseFunctions.signInWithGoogle();
                  if (user != null) {
                    Navigator.of(context).pushReplacementNamed(Home.routeName);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'loginWithGoogle'.tr(),
        
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
