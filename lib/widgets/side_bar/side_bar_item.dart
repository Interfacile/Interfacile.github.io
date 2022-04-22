import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final bool isSelected;
  const SideBarItem({Key? key, required this.icon, required this.title, required this.onTap, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            width: isSelected ? 295 : 300,
            height: 50,
            color: isSelected ? InterfacileTheme.black : Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(icon, color: isSelected ? InterfacileTheme.primaryBlue : InterfacileTheme.grey, size: 30),
                ),
                Text(title, style: InterfacileTheme.bodyText1.copyWith(color: isSelected ? InterfacileTheme.primaryBlue : InterfacileTheme.grey)),
              ],
            ),
          ),
          if (isSelected)
            Container(
              width: 5,
              height: 50,
              color: InterfacileTheme.primaryBlue,
              child: const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
