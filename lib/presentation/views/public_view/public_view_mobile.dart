import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model_mobile.dart';

class PublicViewMobile extends StatelessWidget {
  final PublicViewModel model;
  final BoxConstraints constraints;

  const PublicViewMobile({
    Key key,
    @required this.model,
    @required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Welcome to Peacock and Quill',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          TextFormField(
            controller: model.controller,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: 'Enter Presentation Code',
              prefixIcon: Icon(Icons.add_to_queue),
            ),
            onChanged: model.handleCodeChanged,
            validator: (value) {
              if (!model.isValid) {
                return 'This is not a valid code.';
              }
              return null;
            },
          ),
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: model.handle3rdPartyLogin(AuthType.google),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<bool>(
                future: model.isAppleLoginEnabled,
                builder: (context, snap) {
                  if (snap.hasData && snap.data) {
                    return Opacity(
                      opacity: model.codeIsValid ? 1 : 0.5,
                      child: AppleSignInButton(
                        style: ButtonStyle.black,
                        type: ButtonType.defaultButton,
                        onPressed: model.handle3rdPartyLogin(AuthType.apple),
                        cornerRadius: 50,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ]
            .map((x) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: model.getMaxWidth(constraints),
                  ),
                  child: x,
                ))
            .toList(),
      ),
    );
  }
}
