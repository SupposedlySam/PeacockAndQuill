import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/constants.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: logo(),
    );
  }

  Widget logo() {
    // Web doesn't support svg right now
    return Image.asset(AssetConstants.wordMark);
  }
}
