import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/nav_bar_logo.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/web_end_drawer.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';
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
      create: (context) => BaseViewModel(
        navigator: Navigator.of(context),
        questionUseCase: Provider.of(context, listen: false),
        keyPressModel: Provider.of(context, listen: false),
      ),
      child: Consumer<BaseViewModel>(builder: (context, model, __) {
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
                      ? imageBackground(model, backgroundImage)
                      : Center(child: Text('Loading...')),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget imageBackground(BaseViewModel model, BackgroundImage backgroundImage) {
    return Container(
      child: siteBody(model),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: backgroundImage.value,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget siteBody(BaseViewModel model) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          if (model.showHeader) SliverAppBar(actions: <Widget>[NavBarLogo()]),
          if (model.showQuestions) questionsBar(model),
          spacer()
        ];
      },
      body: buildCenteredView(),
    );
  }

  Widget questionsBar(BaseViewModel model) {
    return SliverToBoxAdapter(
      child: Wrap(
        spacing: 15,
        children: model.questions
            .map(
              (questionsEntity) => questionNavigator(model, questionsEntity),
            )
            .toList(),
      ),
    );
  }

  Widget spacer() {
    return SliverToBoxAdapter(
      child: Container(
        height: 15,
        color: Colors.black54,
      ),
    );
  }

  Widget questionNavigator(
      BaseViewModel model, IQuestionsEntity questionsEntity) {
    return FlatButton(
      onPressed: () => model.handleQuestionPressed(questionsEntity),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Screen ${questionsEntity.screen}',
                style: TextStyle(fontSize: 18),
              ),
              Text('# Qs: ${questionsEntity.questions.length}')
            ],
          ),
        ),
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
