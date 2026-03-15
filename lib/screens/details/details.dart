import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/models/task_model.dart';
import 'package:evently_details/providers/details_provider.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/edit/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  static const String routeName = 'details';

  Details({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    TaskModel arg = ModalRoute.of(context)!.settings.arguments as TaskModel;

    return ChangeNotifierProvider(
      create: (context) => DetailsProvider()..getTaskDetails(arg),
      builder: (context, child) {
        DetailsProvider details = Provider.of<DetailsProvider>(context);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: Text(
              'details'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            actions: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Center(
                  child: IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Edit.routeName,
                        arguments: details.taskModel!,
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Center(
                  child: IconButton(
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () {
                      details.deleteTask(details.taskModel!);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Center(
                      child: Image.asset(
                        'assets/images/${theme.themeMode == ThemeMode.light ? 'light_' : 'dark_'}'
                        '${details.taskModel!.category.toLowerCase().replaceAll(' ', '_')}.png',
                      ),
                    ),
                  ),
                  Text(
                    details.taskModel!.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Container(
                    width: double.infinity,
                    height: 76,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        spacing: 16.0,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                details.getDate(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                details.getTime(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'description'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(
                      details.taskModel!.description,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
