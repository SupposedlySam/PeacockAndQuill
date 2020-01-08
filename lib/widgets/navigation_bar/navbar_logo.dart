import 'package:flutter/material.dart';
import 'package:peacock_and_quill/constants.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetConstants.wordMark);
  }
}
