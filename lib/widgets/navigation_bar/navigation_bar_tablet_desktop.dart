import 'package:flutter/material.dart';

import 'navbar_logo.dart';

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
