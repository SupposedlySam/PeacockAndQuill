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
    return Column(
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
        ),
        RaisedButton(
          child: Text('Login with Google'),
          onPressed: model.handleLogin,
        ),
      ]
          .map((x) => ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: model.getMaxWidth(constraints),
                ),
                child: x,
              ))
          .toList(),
    );
  }
}
