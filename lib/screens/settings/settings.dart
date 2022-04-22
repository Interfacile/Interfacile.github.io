import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:dotspot_beta_web/widgets/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 995) {
      return const TooSmallScreen();
    }
    return Scaffold(
      backgroundColor: InterfacileTheme.black,
      body: Row(
        children: [
          const SideBar(activeIndex: 2,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Settings")
            ],
          )
        ]
      ),
    );
  }
}
