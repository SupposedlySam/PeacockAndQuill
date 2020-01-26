import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/domain/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_content_use_case.dart';

class ContentUseCase implements IContentUseCase {
  final IContentRepository contentRepository;

  ContentUseCase({@required this.contentRepository});

  @override
  Stream<List<IContentEntity>> getContent() {
    return contentRepository.getContent();
  }
}
