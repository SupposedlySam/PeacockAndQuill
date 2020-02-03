import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/web/i_web_only_presentation_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/web/i_web_only_presentation_use_case.dart';

class WebOnlyPresentationUseCase implements IWebOnlyPresentationUseCase {
  final IWebOnlyPresentationRepository presentationRepository;
  final IUserRepository userRepository;

  WebOnlyPresentationUseCase({
    @required this.presentationRepository,
    @required this.userRepository,
  });

  @override
  Future<List<IPresentationEntity>> getPresentations() {
    return presentationRepository.getPresentations();
  }
}
