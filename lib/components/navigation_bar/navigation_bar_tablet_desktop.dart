import 'package:flutter/material.dart';
import 'package:peacock_and_quill/components/navigation_bar/nav_bar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        NavBarLogo(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // NavBarItem('Episodes', EpisodesRoute),
            SizedBox(
              width: 60,
            ),
            // NavBarItem('About', AboutRoute),
          ],
        )
      ],
    );
  }
}
