import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/web_end_drawer.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_user_entity.dart';
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
        userRepository: Provider.of(context, listen: false),
        navigator: Navigator.of(context),
        keyPressModel: Provider.of(context, listen: false),
        presentationRepository: Provider.of(context, listen: false),
        questionUseCase: Provider.of(context, listen: false),
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
          if (model.showHeader)
            SliverAppBar(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.add_to_home_screen),
                    SizedBox(width: 10),
                    Text(
                      model.presentationCode,
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      child: Provider.of<ILogo>(context).getLogo,
                    ),
                    Spacer()
                  ],
                ),
                actions: <Widget>[
                  toggleActive(model),
                ].map(navBarPadding).toList()),
          if (model.showQuestions) questionsBar(model),
          spacer()
        ];
      },
      body: buildCenteredView(model),
    );
  }

  Padding navBarPadding(Widget w) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: w,
    );
  }

  Widget toggleActive(BaseViewModel baseViewModel) {
    return OutlineButton.icon(
      icon: Icon(baseViewModel.isPresenting
          ? Icons.stop_screen_share
          : Icons.screen_share),
      label: Text(
        '${baseViewModel.isPresenting ? 'Stop' : 'Start'} Presenting',
      ),
      onPressed: baseViewModel.toggleActive,
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
    BaseViewModel model,
    IQuestionsEntity questionsEntity,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: FlatButton(
        color: model.currentSlide.round() == questionsEntity.screen
            ? Color(0xFF3FA9F5)
            : Colors.transparent,
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
      ),
    );
  }

  Widget buildCenteredView(BaseViewModel model) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (model.showQuestions) participants(model),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black54,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: child,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget participants(BaseViewModel model) {
    final partipantQuestions = model.participantQuestions;

    return (partipantQuestions?.length ?? 0) > 0
        ? Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: partipantQuestions
                  .asMap()
                  .map(
                    (index, futureEntity) {
                      return MapEntry(
                        index,
                        FutureBuilder(
                          future: futureEntity,
                          builder: (context, snap) {
                            if (snap.hasData) {
                              final userQuestion =
                                  snap.data as IQuestionUserEntity;
                              return ActionChip(
                                key: Key(userQuestion.questionRef),
                                label: Text(userQuestion.name),
                                onPressed: () => model.handleQuestionDelete(
                                  index,
                                  userQuestion.questionRef,
                                ),
                              );
                            }
                            return Chip(
                              label: Text('Loading...'),
                            );
                          },
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
          )
        : Container();
  }
}
