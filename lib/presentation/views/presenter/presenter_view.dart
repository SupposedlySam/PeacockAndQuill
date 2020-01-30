import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:peacock_and_quill/presentation/views/base_view.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_desktop.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_mobile.dart';
import 'package:provider/provider.dart';

class PresenterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageRepository = Provider.of<IStorageRepository>(context);
    return BaseView(
      child: (kIsWeb)
          ? PresenterContentDesktop(storageRepository: storageRepository)
          : _buildHomeContentMobile(context, storageRepository),
    );
  }

  Widget _buildHomeContentMobile(
      BuildContext context, IStorageRepository storageRepository) {
    final presenterViewModel = Provider.of<PresenterViewModel>(context);
    return StreamProvider<IPresentationEntity>.value(
      value: presenterViewModel.getPresentationStream(),
      child: Consumer<IPresentationEntity>(
        builder: (context, presentationEntity, __) {
          return PresenterContentMobile(
            storageRepository: storageRepository,
            currentSlide: presentationEntity?.currentSlide ?? 0,
            isActive: presentationEntity?.isActive ?? false,
          );
        },
      ),
    );
  }
}
