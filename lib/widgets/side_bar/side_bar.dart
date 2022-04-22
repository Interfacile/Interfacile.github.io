import 'package:dotspot_beta_web/controller/preferences.dart';
import 'package:dotspot_beta_web/utils/check_if_logged_in.dart';
import 'package:dotspot_beta_web/widgets/side_bar/side_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class SideBar extends StatefulWidget {
  final int activeIndex;
  const SideBar({Key? key, required this.activeIndex}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    checkIfLoggedIn();
    return Container(
      color: InterfacileTheme.darkBG,
      width: 300,
      child: Column(
        children: [
          InkWell(
            onTap: () => Get.toNamed('/'),
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Image(image: AssetImage('assets/images/Dotspot.png')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 270,
              height: 1,
              color: InterfacileTheme.primaryBlue,
            ),
          ),
          SideBarItem(icon: Icons.speed, title: "Dashboard", onTap: () => Get.toNamed('/dashboard'), isSelected: widget.activeIndex == 0),
          SideBarItem(icon: Icons.description, title: "Médias", onTap: () => Get.toNamed('/'), isSelected: widget.activeIndex == 1),
          SideBarItem(icon: Icons.manage_accounts, title: "Paramètres", onTap: () => Get.toNamed('/settings'), isSelected: widget.activeIndex == 2),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 270,
              height: 1,
              color: InterfacileTheme.primaryBlue,
            ),
          ),
          SideBarItem(icon: Icons.notifications, title: "Notifications", onTap: () => Get.toNamed('/notifications'), isSelected: widget.activeIndex == -2),
          SideBarItem(icon: Icons.power_settings_new, title: "Deconnection", onTap: () {
            setState(() {
              final IFPreferences prefs = IFPreferences.getInstance();
              prefs.setValue<String>("isLoggedIn", false.toString());
              prefs.setValue<String>("userId", "");
            });
          }, isSelected: widget.activeIndex == -1),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
