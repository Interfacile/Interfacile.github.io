import 'package:dotspot_common/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 300,
      height: 50,
      decoration: BoxDecoration(
          color: InterfacileTheme.black,
          boxShadow: [InterfacileTheme.shadow1,]
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          IFSimpleButton(
            onPressed: () => Get.toNamed('/'),
            text: "Revenir à la bibliothèque",
            color: InterfacileTheme.secondaryLightOrange,
            textColor: InterfacileTheme.black,
            height: 50,
            width: 230,
          )
        ],
      ),
    );
  }
}
