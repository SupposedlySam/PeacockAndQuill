import 'navigation_bar_imports.dart';

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
