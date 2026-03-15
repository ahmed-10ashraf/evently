import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/providers/auth_provider.dart';
import 'package:evently_details/providers/home_page_provider.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/details/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  DateFormat formatter = DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => HomePageProvider()..getStreamTasks(),
      builder: (context, child) {
        HomePageProvider homePage = Provider.of<HomePageProvider>(context);
        HomePageProvider providerWatch = context.watch<HomePageProvider>();

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcomeBack'.tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  authProvider.userModel?.name ?? 'NA',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            actions: [
              IconButton(
                splashRadius: 24,
                onPressed: () {
                  if (theme.themeMode == ThemeMode.light) {
                    theme.changeTheme(ThemeMode.dark);
                  } else {
                    theme.changeTheme(ThemeMode.light);
                  }
                },
                icon: ImageIcon(
                  AssetImage(
                    'assets/images/${theme.themeMode == ThemeMode.light ? 'sun.png' : 'moon.png'}',
                  ),
                ),
              ),
              const SizedBox(width: 4),
              ElevatedButton(
                onPressed: () {
                  if (context.locale == const Locale('ar', 'EG')) {
                    context.setLocale(const Locale('en', 'US'));
                  } else {
                    context.setLocale(const Locale('ar', 'EG'));
                  }
                },
                child: context.locale == const Locale('ar', 'EG')
                    ? Text('ar'.tr())
                    : Text('en'.tr()),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 24,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        homePage.changeIndex(index);
                      },
                      child: Chip(
                        label: Text(homePage.categories[index]),
                        labelStyle: homePage.selectedIndex == index
                            ? GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                        )
                            : Theme.of(context).textTheme.bodyMedium,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: homePage.selectedIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    itemCount: homePage.categories.length,
                  ),
                ),
                Expanded(
                  child: homePage.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : homePage.errorMassage.isNotEmpty
                      ? Center(child: Text(homePage.errorMassage))
                      : providerWatch.events.isEmpty
                      ? Center(child: Text('noEvents'.tr()))
                      : ListView.separated(
                    itemBuilder: (context, index) {
                      return Slidable(
                        // Specify a key if the Slidable is dismissible.
                        key: const ValueKey(0),

                        startActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const DrawerMotion(),

                          // A pane can dismiss the Slidable.
                          dismissible: DismissiblePane(onDismissed: () {}),

                          // All actions are defined in the children parameter.
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: (context) {
                                providerWatch.deleteTask(index);
                              },
                              backgroundColor: Theme.of(context).colorScheme.error,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.delete,
                              label: 'delete'.tr(),
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).pushNamed(Details.routeName, arguments: providerWatch.events[index]);
                              },
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.list_alt,
                              label: 'details'.tr(),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 193,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/images/${theme.themeMode == ThemeMode.light ? 'light_' : 'dark_'}${providerWatch.events[index].category.toLowerCase().replaceAll(' ', '_')}.png',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                      ),
                                      child: Text(
                                        formatter.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            providerWatch.events[index].date,
                                          ),
                                        ),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            providerWatch.events[index].title,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              var task = providerWatch.events[index];
                                              task.isFavorite = !task.isFavorite;
                                              FirebaseFunctions.updateTask(task);
                                            },
                                            child: Icon(providerWatch.events[index].isFavorite ? Icons.favorite : Icons.favorite_border),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16),
                    itemCount: providerWatch.events.length,
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
