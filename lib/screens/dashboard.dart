import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:dotspot_beta_web/widgets/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
          SideBar(activeIndex: 0)
        ],
      ),
    );
  }
}
