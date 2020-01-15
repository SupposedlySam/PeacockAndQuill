import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:provider/provider.dart';

class HomeContentMobile extends StatelessWidget {
  final List<Widget> pages;

  const HomeContentMobile({@required this.pages});

  @override
  Widget build(BuildContext context) {
    final entity = Provider.of<PresentationEntity>(context);

    return pages[entity.currentSlide];
  }
}
