import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peacock_and_quill/domain/constants.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';

class Logo extends ILogo {
  Widget get getLogo => SvgPicture.asset(
        AssetConstants.wordMarkSVG,
        height: 50,
        width: 100,
        excludeFromSemantics: true,
      );
}
