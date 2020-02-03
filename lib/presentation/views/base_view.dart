import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_view_model.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/nav_bar_logo.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/web_end_drawer.dart';
import 'package:peacock_and_quill/presentation/view_models/base_view_model.dart';
import 'package:peacock_and_quill/presentation/views/components/status_bar_dark_mode.dart';
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

    return ChangeNotifierProvider<BaseViewModel>(
      create: (context) =>
          BaseViewModel(questionUseCase: Provider.of(context, listen: false)),
      child: Consumer2<BaseViewModel, KeyPressViewModel>(
          builder: (context, baseModel, keyPressModel, __) {
        final drawer = kIsWeb
            ? WebEndDrawer(
                authorizationUseCase: Provider.of(context),
              )
            : EndDrawer(
                authorizationUseCase: Provider.of(context),
              );

        return StatusBarDarkMode(
          child: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              return Scaffold(
                drawer: kIsWeb ? drawer : null,
                endDrawer: kIsWeb ? null : drawer,
                body: SafeArea(
                  child: backgroundImage?.value != null
                      ? Container(
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) {
                              return [
                                if (baseModel.showHeader)
                                  SliverAppBar(actions: <Widget>[NavBarLogo()]),
                                if (baseModel.showQuestions)
                                  SliverToBoxAdapter(
                                    child: Wrap(
                                      spacing: 15,
                                      children: baseModel.questions
                                          .map(
                                            (q) => FlatButton(
                                              onPressed: () {
                                                keyPressModel
                                                    .navigateToSlide(q.screen);
                                                baseModel.toggleQuestions();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                width: 150,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Screen ${q.screen}',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                          '# Qs: ${q.questions.length}')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
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
      }),
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
