import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class TooSmallScreen extends StatelessWidget {
  const TooSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InterfacileTheme.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "L'écran est trop petit",
              style: InterfacileTheme.title1,
            ),
            const SizedBox(height: 16),
            Text(
              "Sur ordinateur, agrandissez la fenetre\nSi vous êtes sur smartphone/tablette utilisez l'application Dotspot",
              style: InterfacileTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
