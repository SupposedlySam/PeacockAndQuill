import 'navigation_bar_imports.dart';

class NavigationBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authorization>(context);
    final model = Provider.of<NavBarMobileViewModel>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  return model.value = !model.value;
                },
              ),
              NavBarLogo()
            ],
          ),
          if (model.value)
            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('Login with Google'),
                  onPressed: auth.googleSignIn,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class NavBarMobileViewModel extends ValueNotifier<bool> {
  NavBarMobileViewModel({@required bool value}) : super(value);
}
