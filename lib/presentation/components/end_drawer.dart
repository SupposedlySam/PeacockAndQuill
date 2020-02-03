import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/constants.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';

class EndDrawer extends StatelessWidget {
  final IAllAuthorizationUseCase authorizationUseCase;

  const EndDrawer({Key key, @required this.authorizationUseCase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authorizationUseCase.getUser,
        builder: (context, snap) {
          if (snap.hasData) {
            final user = snap.data;
            return Drawer(
              child: Scaffold(
                appBar: AppBar(title: Text('Menu')),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        _subtitle('User Info'),
                        _userInfo(context, user),
                      ]),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Column _subtitle(String title) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Divider(),
        SizedBox(height: 15),
      ],
    );
  }

  Container _userInfo(BuildContext context, FirebaseUser user) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          const Radius.circular(15),
        ),
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: _circleAvatar(user),
            title: Text(user.displayName ?? 'Apple User'),
            subtitle: Text(user.email),
            onTap: authorizationUseCase.disconnect,
          ),
          if (user != null)
            Container(
              margin: const EdgeInsets.all(15),
              height: 45,
              width: double.infinity,
              child: logoutButton(context),
            ),
        ],
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return RaisedButton(
      child: Text('Logout'),
      onPressed: () async {
        await authorizationUseCase.logout();
        Navigator.of(context).pop();
      },
    );
  }

  LayoutBuilder _circleAvatar(FirebaseUser user) {
    return LayoutBuilder(
      builder: (_, constraints) => ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: math.min(constraints.maxWidth / 4, 50)),
        child: AspectRatio(
          aspectRatio: 1,
          child: CircleAvatar(
            backgroundImage: user.photoUrl != null
                ? NetworkImage(user.photoUrl)
                : AssetImage(AssetConstant.defaultAvatar),
          ),
        ),
      ),
    );
  }
}
