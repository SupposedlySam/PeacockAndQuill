import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';
import 'package:peacock_and_quill/presentation/views/public_view/public_view_mobile.dart';
import 'package:peacock_and_quill/presentation/views/public_view/public_view_web.dart';
import 'package:peacock_and_quill/providers/state_manager.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PublicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backgroundImage = Provider.of<BackgroundImage>(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          key: Provider.of<GlobalKey<ScaffoldState>>(context),
          body: SafeArea(
            child: backgroundImage?.value != null
                ? Container(
                    child: buildCenteredView(context),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: backgroundImage.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Center(child: Text('Loading...')),
          ),
        );
      },
    );
  }

  Widget buildCenteredView(BuildContext context) {
    return StateManager(
        changeNotifier: () => Provider.of<BasePublicViewModel>(context),
        builder: (context, model) {
          return LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.black54,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: kIsWeb
                        ? PublicViewWeb(
                            model: model,
                            constraints: constraints,
                          )
                        : PublicViewMobile(
                            model: model,
                            constraints: constraints,
                          ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}