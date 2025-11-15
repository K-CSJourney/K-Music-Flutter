import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../widget/card_widget.dart';

class InitItemWidget extends StatelessWidget {
  const InitItemWidget(
    this.name,
    this.icon,
    this.selected, {
    super.key,
    this.onTap,
  });

  final String name;

  final String icon;

  final bool selected;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Color textColor;
    if (Get.isDarkMode) {
      textColor = theme.colorScheme.primary;
    } else if (selected) {
      textColor = theme.colorScheme.onPrimary;
    } else {
      textColor = theme.colorScheme.primary;
    }
    return CardWidget(
      onTap: onTap,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 15,
      ),
      selected: selected,
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 48,
            height: 48,
          ),
          Text(
            name,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
