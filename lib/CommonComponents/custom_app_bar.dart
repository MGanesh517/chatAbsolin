import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  final GlobalKey<ScaffoldState>? drawerKey;
  final bool? centertitle;
  final Color? appBarBGColor;
  final VoidCallback? leadingLink;
  final Widget? leadingChild;
  final Widget? titleChild;

  final List<Widget>? actionsWidget;
  const CustomAppBar({Key? key, this.appBarBGColor, this.leadingLink, this.leadingChild, this.titleChild, this.actionsWidget, this.drawerKey, this.centertitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: appBarBGColor 
      // ?? Theme.of(context).colorScheme.primary
      ,
      leading: leadingChild == null
          ? null
          : Align(
              alignment: Alignment.center,
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: leadingLink,
                child: leadingChild,
              ),
            ),
      title: titleChild,
      actions: actionsWidget,
      centerTitle: centertitle,
      automaticallyImplyLeading: false,
    );
  }
}
