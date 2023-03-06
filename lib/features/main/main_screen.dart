import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_app/data/client/api_client.dart';
import 'package:social_app/features/adding/adding_screen.dart';
import 'package:social_app/features/search/search_screen.dart';

import '../../custom_widgets/app_icon.dart';
import '../chat/chat_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class BottomBarItemValue {
  final AppIcons icon;
  final AppIcons selectedIcon;

  const BottomBarItemValue({
    required this.icon,
    required this.selectedIcon,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = PersistentTabController();

  late final _items = const [
    BottomBarItemValue(
      icon: AppIcons.home,
      selectedIcon: AppIcons.home,
    ),
    BottomBarItemValue(
      icon: AppIcons.search,
      selectedIcon: AppIcons.search,
    ),
    BottomBarItemValue(
      icon: AppIcons.add,
      selectedIcon: AppIcons.add,
    ),
    BottomBarItemValue(
      icon: AppIcons.chat,
      selectedIcon: AppIcons.chat,
    ),
    BottomBarItemValue(
      icon: AppIcons.person,
      selectedIcon: AppIcons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final index = controller.index;

    return PersistentTabView(
      context,
      controller: controller,
      backgroundColor: Theme.of(context).colorScheme.surface,
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 5),
            spreadRadius: 8.0,
            blurRadius: 12.0,
          )
        ],
      ),
      navBarHeight: 80,
      navBarStyle: NavBarStyle.style8,
      onItemSelected: (index) {
        setState(() {});
      },
      screens: [
        HomeScreen(
          apiService: ApiService(),
        ),
        SearchScreen(),
        AddingScreen(),
        ChatScreen(),
        ProfileScreen(),
      ],
      items: _items
          .asMap()
          .entries
          .map((e) => PersistentBottomNavBarItem(
                opacity: 0.9,
                contentPadding: 1,
                icon: AppIcon(
                  index == e.key ? e.value.selectedIcon : e.value.icon,
                  color: index == e.key
                      ? Theme.of(context).primaryColor
                      : const Color(0xFFA1A1A1),
                  size: 25,
                ),
                activeColorPrimary: Theme.of(context).primaryColor,
                inactiveColorPrimary: const Color(0xFFA1A1A1),
              ))
          .toList(),
    );
  }
}
