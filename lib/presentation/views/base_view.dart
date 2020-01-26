import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BaseView extends StatelessWidget {
  final Widget child;

  const BaseView({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Provider.of<BackgroundImage>(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          key: Provider.of<GlobalKey<ScaffoldState>>(context),
          endDrawer: EndDrawer(
            authorizationUseCase: Provider.of(context),
          ),
          body: SafeArea(
            child: backgroundImage?.value != null
                ? Container(
                    child: buildCenteredView(),
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

  Widget buildCenteredView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.black54,
      child: Column(
        children: <Widget>[
          NavigationBar(),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
