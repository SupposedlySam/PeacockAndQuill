import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:provider/provider.dart';

class HomeContentMobile extends StatelessWidget {
  final List<Widget> pages;

  const HomeContentMobile({@required this.pages});

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<PresentationEntity>(context);

    final viewModel = PresenterViewModel();

    return StreamBuilder(
      stream: viewModel.getPresentation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final PresentationEntity entity = snapshot.data;
          return pages[entity.currentSlide];
        }
        return Center(
          child: Text("Not found"),
        );
      },
    );
  }
}
