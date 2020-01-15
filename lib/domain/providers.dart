import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/authorization.dart';
import 'package:peacock_and_quill/data/repositories/firestore/firestore_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositores/firestore/firestore_web.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_firestore.dart';
import 'package:peacock_and_quill/domain/routing/navigation_entity.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_mobile.dart';
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
