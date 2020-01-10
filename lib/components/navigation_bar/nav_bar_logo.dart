import 'package:flutter/material.dart';
import 'package:peacock_and_quill/constants.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Image.asset(AssetConstants.wordMark),
    );
  }
}
