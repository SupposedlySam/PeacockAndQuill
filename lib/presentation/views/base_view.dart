import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/nav_bar_logo.dart';
import 'package:peacock_and_quill/presentation/views/components/status_bar_dark_mode.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BaseView extends StatelessWidget {
  final bool isWebSelectPage;
  final Widget child;

  const BaseView({
    @required this.child,
    this.isWebSelectPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundImage = isWebSelectPage
        ? Provider.of<WebSelectPresentationBackgroundImage>(context)
        : Provider.of<BackgroundImage>(context);
    final drawer = EndDrawer(
      authorizationUseCase: Provider.of(context),
    );

    return StatusBarDarkMode(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return Scaffold(
            key: Provider.of<GlobalKey<ScaffoldState>>(context),
            drawer: kIsWeb ? drawer : null,
            endDrawer: kIsWeb ? null : drawer,
            body: SafeArea(
              child: backgroundImage?.value != null
                  ? Container(
                      child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverAppBar(actions: <Widget>[NavBarLogo()]),
                            SliverToBoxAdapter(
                              child: Container(
                                height: 15,
                                color: Colors.black54,
                              ),
                            )
                          ];
                        },
                        body: buildCenteredView(),
                      ),
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
      ),
    );
  }

  Widget buildCenteredView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.black54,
      child: Column(
        children: <Widget>[
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
