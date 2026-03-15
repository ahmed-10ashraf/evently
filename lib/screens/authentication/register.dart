import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/evently_textfield.dart';

class Register extends StatefulWidget {
  static const String routeName = 'register';

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'signUpTitle'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    EventlyTextfield(
                      hint: 'userName'.tr(),
                      controller: nameController,
                      validation: 'Invalid Name',
                      prefixIcon: 'user.png',
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    EventlyTextfield(
                      hint: 'userPasswordConfirm'.tr(),
                      password: true,
                      controller: confirmPasswordController,
                      confirmController: passwordController,
                      validation: 'Password Should be match',
                      prefixIcon: 'lock.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 52),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFunctions.createUser(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                  }
                },
                child: Text(
                  'signUp'.tr(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'loginText'.tr(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Login.routeName);
                    },
                    child: Text('login'.tr()),
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  FirebaseFunctions.signInWithGoogle();
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
                    Text('loginWithGoogle'.tr()),
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
