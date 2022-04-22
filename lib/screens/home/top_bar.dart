import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class TopBar extends StatelessWidget {
  final bool all;
  final Function onTapAll;
  final Function onTapNotAll;
  const TopBar({Key? key, required this.all, required this.onTapAll, required this.onTapNotAll}) : super(key: key);

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
          InkWell(child: FilterItem(isActive: all, text: "Tous"), onTap: () => onTapAll,),
          InkWell(child: FilterItem(isActive: !all, text: "Assignés à moi"), onTap: () => onTapNotAll),
        ],
      ),
    );
  }
}


class FilterItem extends StatelessWidget {
  final bool isActive;
  final String text;
  const FilterItem({Key? key, required this.isActive, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? InterfacileTheme.secondaryLightOrange : Colors.transparent, width: 1)
      ),
      child: Text(text, style: InterfacileTheme.bodyText1.copyWith(color: isActive ? InterfacileTheme.secondaryLightOrange : InterfacileTheme.darkBG),),
    );
  }
}

