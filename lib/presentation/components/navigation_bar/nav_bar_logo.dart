import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = locator<GlobalKey<ScaffoldState>>().currentState;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
          child: InkWell(child: locator<ILogo>().getLogo),
          onTap: () {
            if (scaffold.isEndDrawerOpen) {
              Navigator.of(context).pop();
            } else {
              scaffold.openEndDrawer();
            }
          }),
    );
  }
}
