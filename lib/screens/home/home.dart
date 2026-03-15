import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/providers/home_provider.dart';
import 'package:evently_details/screens/add_event/add_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tabs/favorite_page.dart';
import 'tabs/home_page.dart';
import 'tabs/profile_page.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';

  Home({super.key});

  List<Widget> tabs = [HomePage(), FavoritePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        builder: (context, child) {
          HomeProvider home = Provider.of<HomeProvider>(context);

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: tabs[home.selectedIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddEvent.routeName);
              },
              child: Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: home.selectedIndex,
              onTap: (index) {
                home.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/home.png')),
                  label: 'home'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/heart.png')),
                  label: 'favorite'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/user.png')),
                  label: 'profile'.tr(),
                ),
              ],
            ),
          );
        }
    );
  }
}
