import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/constants.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/base_view_model.dart';
import 'package:provider/provider.dart';

class WebEndDrawer extends StatelessWidget {
  final IAllAuthorizationUseCase authorizationUseCase;

  const WebEndDrawer({Key key, @required this.authorizationUseCase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authorizationUseCase.getUser,
        builder: (context, snap) {
          if (snap.hasData) {
            final user = snap.data;
            final model = Provider.of<BaseViewModel>(context);

            return Material(
              child: Drawer(
                child: Scaffold(
                  appBar: AppBar(title: Text('Menu')),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          OutlineButton.icon(
                            icon: Icon(Icons.question_answer),
                            label: Text(
                              '${model.showQuestions ? 'Hide' : 'Show'} Questions',
                            ),
                            onPressed: model.toggleQuestions,
                          ),
                          Spacer(),
                          _userInfo(context, user),
                        ],
                      ),
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
