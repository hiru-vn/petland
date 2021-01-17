import 'package:flutter/material.dart';

import 'font.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final List<Widget> actions;
  final Color bgColor;
  final Widget leading;
  final String title;
  final bool automaticallyImplyLeading;
  final bool centerTitle;

  MyAppBar(
      {this.actions,
      this.bgColor,
      this.leading,
      this.title,
      this.centerTitle = false,
      this.automaticallyImplyLeading = false});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      centerTitle: centerTitle,
      title: Row(
        mainAxisSize: centerTitle ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (!automaticallyImplyLeading) ...[
            Image.asset(
              'assets/image/logo.png',
              height: 27,
              width: 27,
            ),
            SizedBox(
              width: 7,
            ),
          ],
          Text(
            title ?? 'Petland',
            style: ptBigTitle().copyWith(
                color: (bgColor != null && bgColor != Colors.white) ? Colors.white : Colors.black87),
          ),
        ],
      ),
      actions: actions,
    );
  }
}