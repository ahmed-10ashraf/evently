import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/models/task_model.dart';
import 'package:evently_details/providers/add_event_provider.dart';
import 'package:evently_details/providers/theme_provider.dart';
import 'package:evently_details/screens/home/home.dart';
import 'package:evently_details/screens/home/tabs/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatelessWidget {
  static const String routeName = 'addEvent';

  AddEvent({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => AddEventProvider(),
      builder: (context, child) {
        AddEventProvider addEvent = Provider.of<AddEventProvider>(context);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: Text(
              'addEvent'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
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
                        '${addEvent.categories[addEvent.selectedIndex].toLowerCase().replaceAll(' ', '_')}.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          addEvent.changeIndex(index);
                        },
                        child: Chip(
                          label: Text(addEvent.categories[index]),
                          labelStyle: addEvent.selectedIndex == index
                              ? GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                )
                              : Theme.of(context).textTheme.bodyMedium,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: addEvent.selectedIndex == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemCount: addEvent.categories.length,
                    ),
                  ),
                  Text(
                    'title'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextField(
                    controller: titleController,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'eventTitle'.tr(),
                      hintStyle: Theme.of(context).textTheme.displaySmall,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                  Text(
                    'description'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextField(
                    controller: descriptionController,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: 'eventDescription'.tr(),
                      hintStyle: Theme.of(context).textTheme.displaySmall,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          ImageIcon(AssetImage('assets/images/calendar.png')),
                          Text(
                            'eventDate'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          DateTime? chosenDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialDate: DateTime.now(),
                          );
                          if (chosenDate != null) {
                            addEvent.changeDate(chosenDate);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                        child: Text(
                          addEvent.selectedDate != null
                              ? DateFormat(
                                  'MMM dd, yyyy',
                                ).format(addEvent.selectedDate!)
                              : 'chooseDate'.tr(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          ImageIcon(AssetImage('assets/images/clock.png')),
                          Text(
                            'eventTime'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? chosenTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (chosenTime != null) {
                            addEvent.changeTime(chosenTime);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                        child: Text(
                          addEvent.selectedTime?.format(context) ?? 'chooseTime'.tr(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        addEvent.addEvent(
                          TaskModel(
                            category: addEvent.categories[addEvent.selectedIndex],
                            title: titleController.text,
                            description: descriptionController.text,
                            date: addEvent.selectedDate!.millisecondsSinceEpoch,
                            time: addEvent.selectedTime!.toString(),
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          ),
                        );

                        Navigator.of(context).pushNamed(Home.routeName);
                      },
                      child: Text('addEvent'.tr()),
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
