import 'package:flutter/material.dart';
import 'package:peacock_and_quill/components/navigation_bar/navigation_bar_mobile.dart';
import 'package:peacock_and_quill/interfaces/i_firestore.dart';
import 'package:peacock_and_quill/locator.dart';
import 'package:peacock_and_quill/models/navigation_entity.dart';
import 'package:peacock_and_quill/services/api.dart';
import 'package:peacock_and_quill/services/authorization.dart';
import 'package:peacock_and_quill/services/firestore/firestore_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/services/firestore/firestore_web.dart';
import 'package:peacock_and_quill/view_models/key_press_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers extends StatefulWidget {
  final Widget child;

  Providers({@required this.child});

  @override
  _ProvidersState createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {
  Firestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = Firestore();
  }

  List<SingleChildWidget> get independentProviders => [
        Provider<Api>.value(value: Api()),
        Provider<NavigationEntity>.value(value: NavigationEntity()),
        ChangeNotifierProvider<NavBarMobileViewModel>.value(
          value: NavBarMobileViewModel(value: false),
        ),
      ];

  List<SingleChildWidget> get dependentProviders => [
        ProxyProvider<IFirestore, Authorization>(
          update: (_, firestore, __) => Authorization(firestore: firestore),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IFirestore>.value(value: firestore),
        ...independentProviders,
        ...dependentProviders,
      ],
      child: widget.child,
    );
  }
}
