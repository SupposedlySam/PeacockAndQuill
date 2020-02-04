import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/constants.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/base_view_model.dart';
import 'package:peacock_and_quill/presentation/views/components/font_size_notifier.dart';
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
            final fontSize = Provider.of<FontSizeNotifier>(context);

            return Material(
              child: Drawer(
                child: Scaffold(
                  appBar: AppBar(title: Text('Controls')),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _fontSizeControl(fontSize),
                          _toggleQuestions(model),
                          _toggleActive(model),
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

  Widget _fontSizeControl(FontSizeNotifier fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: OutlineButton(
            onPressed: () {
              return fontSize.value = fontSize.value - 3;
            },
            child: Icon(Icons.remove),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: OutlineButton(
            onPressed: () {
              return fontSize.value = fontSize.value + 3;
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _toggleQuestions(BaseViewModel model) {
    return OutlineButton.icon(
      icon: Icon(Icons.question_answer),
      label: Text(
        '${model.showQuestions ? 'Hide' : 'Show'} Questions',
      ),
      onPressed: model.toggleQuestions,
    );
  }

  Widget _toggleActive(BaseViewModel model) {
    return OutlineButton.icon(
      icon: Icon(
          model.isPresenting ? Icons.stop_screen_share : Icons.screen_share),
      label: Text(
        '${model.isPresenting ? 'Stop' : 'Start'} Presenting',
      ),
      onPressed: model.toggleActive,
    );
  }

  Widget _userInfo(BuildContext context, FirebaseUser user) {
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
