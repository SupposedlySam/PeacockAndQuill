import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/nav_bar_logo.dart';

class EndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0)
            .copyWith(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NavBarLogo(),
          ],
        ),
      ),
    );
  }
}
