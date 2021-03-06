import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/nav_bar_view_model.dart';

import 'navigation_bar_imports.dart';

class NavigationBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<IAllAuthorizationUseCase>(context);
    final model = Provider.of<NavBarViewModel>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[NavBarLogo()],
            ),
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
