import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/domain/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_question_use_case.dart';

class QuestionUseCase implements IQuestionUseCase {
  final IQuestionRepository questionRepository;
  final IAuthorizationUseCase authorizationUseCase;

  QuestionUseCase({
    @required this.questionRepository,
    @required this.authorizationUseCase,
  });

  void addQuestion(int screen, int paragraph) async {
    final user = await authorizationUseCase.getUser;

    if (user != null) {
      questionRepository.addQuestion(user.uid, screen, paragraph);
    }
  }

  Future<List<IQuestionEntity>> getAllQuestions() {
    return questionRepository.getAllQuestions();
  }

  Future<List<IQuestionEntity>> getQuestions(int slide) {
    return questionRepository.getQuestionsBySlide(slide);
  }

  Stream<List<IQuestionEntity>> getQuestionsByUser() {
    return questionRepository.getQuestionsByUser();
  }

  void removeQuestion(int screen, int paragraph) async {
    questionRepository.removeQuestion(screen, paragraph);
  }

  @override
  Future<bool> hasQuestion(int pageIndex, int paragraphIndex) {
    return questionRepository.hasQuestion(pageIndex, paragraphIndex);
  }
}
