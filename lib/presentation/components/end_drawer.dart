import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/domain/use_cases/authorization.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/nav_bar_logo.dart';
import 'package:provider/provider.dart';

class EndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0)
            .copyWith(top: MediaQuery.of(context).padding.top),
        child: Consumer<FirebaseUser>(
          builder: (_, user, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  NavBarLogo(),
                  if (user == null)
                    RaisedButton(
                      child: Text('Login with Google'),
                      onPressed: () async {
                        await locator<Authorization>().googleSignIn();
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
              Spacer(),
              if (user != null)
                Container(
                  height: 45,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('Logout'),
                    onPressed: () async {
                      await locator<Authorization>().logout();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
