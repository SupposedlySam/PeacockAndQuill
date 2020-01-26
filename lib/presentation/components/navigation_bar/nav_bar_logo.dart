import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';
import 'package:provider/provider.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold =
        Provider.of<GlobalKey<ScaffoldState>>(context).currentState;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
          child: InkWell(child: Provider.of<ILogo>(context).getLogo),
          onTap: () {
            if (scaffold.isEndDrawerOpen || scaffold.isDrawerOpen) {
              Navigator.of(context).pop();
            } else {
              if (scaffold.hasDrawer) {
                scaffold.openDrawer();
              } else {
                scaffold.openEndDrawer();
              }
            }
          }),
    );
  }
}
