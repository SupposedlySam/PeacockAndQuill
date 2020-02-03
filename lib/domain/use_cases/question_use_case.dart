import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/domain/entities/questions_entity.dart';
import 'package:peacock_and_quill/domain/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_question_use_case.dart';

class QuestionUseCase implements IQuestionUseCase {
  final IQuestionRepository questionRepository;
  final IAllAuthorizationUseCase authorizationUseCase;

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

  Future<List<IQuestionsEntity>> getAllQuestions() async {
    final questions = await questionRepository.getAllQuestions();

    final groupedQuestions = groupBy(questions, (q) => q.selection.slide);

    return groupedQuestions
        .map(
          (k, v) => MapEntry(
            k,
            QuestionsEntity(screen: k, questions: v),
          ),
        )
        .values
        .toList();
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
