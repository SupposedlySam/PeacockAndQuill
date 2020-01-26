import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model_web.dart';

class PublicViewWeb extends StatelessWidget {
  final PublicViewModel model;
  final BoxConstraints constraints;

  const PublicViewWeb({
    Key key,
    @required this.model,
    @required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome to Peacock and Quill',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: 200,
            child: RaisedButton(
              child: Text('Login with Google'),
              onPressed: model.handleLogin,
            ),
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
