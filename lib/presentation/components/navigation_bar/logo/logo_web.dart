import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';
import 'package:peacock_and_quill/presentation/constants.dart';

class Logo extends ILogo {
  Widget get getLogo => Image.asset(
        AssetConstant.wordMark,
        height: 50,
        width: 100,
        excludeFromSemantics: true,
      );
}
