import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/view_models/home_content_web_view_model.dart';
import 'package:peacock_and_quill/state/state_manager.dart';
import 'package:provider/provider.dart';

class HomeContentWeb extends StatelessWidget {
  final IStorageRepository storageRepository;

  const HomeContentWeb({
    @required this.storageRepository,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundImage =
        Provider.of<WebSelectPresentationBackgroundImage>(context);

    return StateManager<HomeContentWebViewModel>(
      changeNotifier: () => HomeContentWebViewModel(
        navigator: Navigator.of(context),
        storageRepository: storageRepository,
        userRepository: Provider.of(context),
        presentationUseCase: Provider.of(context),
      ),
      onReady: (model) {
        return model.getPresentations();
      },
      shouldDispose: true,
      builder: (context, model) {
        if (model.presentations != null) {
          if (model.presentations.length > 0) {
            return Stack(
              children: <Widget>[
                Image.network(
                  backgroundImage.value.url,
                  fit: BoxFit.fitHeight,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: model.presentations.map(
                    (entity) {
                      return presentationItem(model, entity);
                    },
                  ).toList(),
                )
              ],
            );
          }
          return Center(
            child: Text(
              "I'm sorry, we couldn't find any presentations for this user.",
            ),
          );
        }
        return Center(child: Text('Loading...'));
      },
    );
  }

  Widget presentationItem(
      HomeContentWebViewModel model, IPresentationEntity entity) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RaisedButton(
        color: Color(0xFF121212),
        onPressed: () {
          model.handlePresentationSelect(entity.refId);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            entity.title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
