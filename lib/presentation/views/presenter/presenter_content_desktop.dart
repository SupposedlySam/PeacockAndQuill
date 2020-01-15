import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/lifecycle_managers/key_press_page_manager.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:provider/provider.dart';

class HomeContentDesktop extends StatelessWidget {
  final List<Widget> pages;

  const HomeContentDesktop({@required this.pages});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PresenterViewModel>(context);

    return KeyPressPageManager(
      builder: (context, controller) {
        // listen to the page transition
        model.listen(controller);

        return PageView.builder(
          controller: controller,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        );
      },
    );
  }
}
