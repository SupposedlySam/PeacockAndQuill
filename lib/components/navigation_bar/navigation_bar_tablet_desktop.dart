import 'package:flutter/material.dart';
import 'package:peacock_and_quill/components/navigation_bar/nav_bar_logo.dart';
import 'package:peacock_and_quill/services/authorization.dart';
import 'package:provider/provider.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authorization>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        NavBarLogo(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text('Login with Google'),
              onPressed: auth.googleSignIn,
            ),
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
