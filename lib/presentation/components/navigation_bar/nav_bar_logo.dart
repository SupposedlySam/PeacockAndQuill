import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: locator<ILogo>().getLogo,
    );
  }
}
