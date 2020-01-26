import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';
import 'package:peacock_and_quill/presentation/constants.dart';

class Logo extends ILogo {
  Widget get getLogo {
    return SvgPicture.asset(
      AssetConstant.logoSVG,
      height: 35,
      width: 35,
      excludeFromSemantics: true,
    );
  }
}
