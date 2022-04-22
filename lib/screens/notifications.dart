import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:dotspot_beta_web/widgets/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 995) {
      return const TooSmallScreen();
    }
    return Scaffold(
      backgroundColor: InterfacileTheme.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SideBar(activeIndex: -2),
        ],
      ),
    );
  }
}
